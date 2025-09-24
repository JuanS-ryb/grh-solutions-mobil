import 'package:flutter/material.dart';
import 'package:grhsolutions/models/contrato/contrato.dart';
import 'package:grhsolutions/services/contrato/contrato-services.dart';
import 'package:intl/intl.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  final ContractService _contractService = ContractService();
  late Future<List<Contract>> _contractsFuture;

  @override
  void initState() {
    super.initState();
    _contractsFuture = _contractService.getContracts();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Funciones para el estado del contrato
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'activo':
        return Colors.greenAccent.shade100;
      case 'inactivo':
        return Colors.grey.shade300;
      case 'por revisar':
        return Colors.orange.shade200;
      case 'aprobado':
        return Colors.lightBlue.shade200;
      case 'reprobado':
        return Colors.redAccent.shade100;
      case 'por firmar':
        return Colors.purpleAccent.shade100;
      case 'firmado':
        return Colors.tealAccent.shade100;
      case 'por renovar':
        return Colors.amber.shade200;
      default:
        return Colors.grey.shade400;
    }
  }

  // Estado de vencimiento
  String getExpiryStatus(DateTime endDate) {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;

    if (difference < 0) return "Venció";
    if (difference <= 7) return "Por vencer";
    return "Vigente";
  }

  Color getExpiryColor(DateTime endDate) {
    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;

    if (difference < 0) return Colors.redAccent.shade100;
    if (difference <= 7) return Colors.orangeAccent.shade100;
    return Colors.greenAccent.shade100;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contratos Laborales'),
      ),
      body: FutureBuilder<List<Contract>>(
        future: _contractsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar contratos: ${snapshot.error}',
                style: TextStyle(color: theme.colorScheme.error),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay contratos disponibles.'),
            );
          }

          final contracts = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: contracts.length,
            itemBuilder: (context, index) {
              final contract = contracts[index];
              return _AnimatedContractCard(
                contract: contract,
                isDark: isDark,
                getStatusColor: getStatusColor,
                formatDate: formatDate,
                getExpiryColor: getExpiryColor,
                getExpiryStatus: getExpiryStatus,
              );
            },
          );
        },
      ),
    );
  }
}

class _AnimatedContractCard extends StatefulWidget {
  final Contract contract;
  final bool isDark;
  final Color Function(String) getStatusColor;
  final String Function(DateTime) formatDate;
  final Color Function(DateTime) getExpiryColor;
  final String Function(DateTime) getExpiryStatus;

  const _AnimatedContractCard({
    Key? key,
    required this.contract,
    required this.isDark,
    required this.getStatusColor,
    required this.formatDate,
    required this.getExpiryColor,
    required this.getExpiryStatus,
  }) : super(key: key);

  @override
  State<_AnimatedContractCard> createState() => _AnimatedContractCardState();
}

class _AnimatedContractCardState extends State<_AnimatedContractCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final contract = widget.contract;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(0, 8),
                    blurRadius: 12,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black12,
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  )
                ],
        ),
        transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    contract.tittle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.getStatusColor(contract.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    contract.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            // Texto de vencimiento
            const SizedBox(height: 4),
            Text(
              widget.getExpiryStatus(contract.updatedAt),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: widget.getExpiryColor(contract.updatedAt),
              ),
            ),

            const SizedBox(height: 6),
            // Fechas y PDF icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Desde',
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        Text(
                          widget.formatDate(contract.createdAt),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: widget.isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hasta',
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        Text(
                          widget.formatDate(contract.updatedAt),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: widget.isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implementar descarga PDF
                  },
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 6),
            // Descripción
            Text(
              contract.description,
              style: TextStyle(
                fontSize: 13,
                color: widget.isDark ? Colors.white70 : Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:grhsolutions/models/contrato/contrato.dart';
// import 'package:grhsolutions/services/contrato/contrato-services.dart';
// import 'package:intl/intl.dart';

// class ContractsPage extends StatefulWidget {
//   const ContractsPage({Key? key}) : super(key: key);

//   @override
//   State<ContractsPage> createState() => _ContractsPageState();
// }

// class _ContractsPageState extends State<ContractsPage> {
//   final ContractService _contractService = ContractService();
//   late Future<List<Contract>> _contractsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _contractsFuture = _contractService.getContracts();
//   }

//   String formatDate(DateTime date) {
//     return DateFormat('dd/MM/yyyy').format(date);
//   }

//   Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'activo':
//         return Colors.greenAccent.shade100;
//       case 'inactivo':
//         return Colors.grey.shade300;
//       case 'por revisar':
//         return Colors.orange.shade200;
//       case 'aprobado':
//         return Colors.lightBlue.shade200;
//       case 'reprobado':
//         return Colors.redAccent.shade100;
//       case 'por firmar':
//         return Colors.purpleAccent.shade100;
//       case 'firmado':
//         return Colors.tealAccent.shade100;
//       case 'por renovar':
//         return Colors.amber.shade200;
//       default:
//         return Colors.grey.shade400;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Contratos'),
//       ),
//       body: FutureBuilder<List<Contract>>(
//         future: _contractsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error al cargar contratos: ${snapshot.error}',
//                 style: TextStyle(color: theme.colorScheme.error),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('No hay contratos disponibles.'),
//             );
//           }

//           final contracts = snapshot.data!;

//           return ListView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             itemCount: contracts.length,
//             itemBuilder: (context, index) {
//               final contract = contracts[index];
//               return _AnimatedContractCard(
//                 contract: contract,
//                 isDark: isDark,
//                 getStatusColor: getStatusColor,
//                 formatDate: formatDate,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// // Widget separado para animación de tarjeta
// class _AnimatedContractCard extends StatefulWidget {
//   final Contract contract;
//   final bool isDark;
//   final Color Function(String) getStatusColor;
//   final String Function(DateTime) formatDate;

//   const _AnimatedContractCard({
//     Key? key,
//     required this.contract,
//     required this.isDark,
//     required this.getStatusColor,
//     required this.formatDate,
//   }) : super(key: key);

//   @override
//   State<_AnimatedContractCard> createState() => _AnimatedContractCardState();
// }

// class _AnimatedContractCardState extends State<_AnimatedContractCard> {
//   bool _isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true),
//       onTapUp: (_) => setState(() => _isPressed = false),
//       onTapCancel: () => setState(() => _isPressed = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: widget.isDark ? Colors.grey.shade900 : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: _isPressed
//               ? [
//                   BoxShadow(
//                     color: Colors.black26,
//                     offset: const Offset(0, 8),
//                     blurRadius: 12,
//                   )
//                 ]
//               : [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: const Offset(0, 3),
//                     blurRadius: 6,
//                   )
//                 ],
//         ),
//         transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Título y estado
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.contract.tittle,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: widget.isDark ? Colors.white : Colors.black87,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: widget.getStatusColor(widget.contract.status),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     widget.contract.status,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             // Tipo de contrato
//             if (widget.contract.typeContract != null)
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: widget.isDark
//                       ? Colors.blueGrey.shade700
//                       : Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   widget.contract.typeContract!,
//                   style: TextStyle(
//                     fontSize: 11,
//                     fontWeight: FontWeight.w500,
//                     color: widget.isDark
//                         ? Colors.blueAccent.shade100
//                         : Colors.blueAccent,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 10),
//             // Fechas y PDF
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Desde',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: widget.isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     Text(
//                       widget.formatDate(widget.contract.createdAt),
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: widget.isDark ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hasta',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: widget.isDark ? Colors.white70 : Colors.black54,
//                       ),
//                     ),
//                     Text(
//                       widget.formatDate(widget.contract.updatedAt),
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: widget.isDark ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                   ],
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // TODO: Implementar descarga de PDF
//                   },
//                   icon: Icon(
//                     Icons.picture_as_pdf,
//                     color: Colors.redAccent.shade200,
//                     size: 24,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             // Descripción
//             Text(
//               widget.contract.description,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: widget.isDark ? Colors.white70 : Colors.black87,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
