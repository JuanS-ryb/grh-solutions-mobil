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
  String getExpiryStatus(DateTime? endDate) {
    if (endDate == null) return "Sin fecha límite";

    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;

    if (difference < 0) return "Venció";
    if (difference <= 7) return "Por vencer";
    return "Vigente";
  }

  Color getExpiryColor(DateTime? endDate) {
    if (endDate == null) return Colors.blueAccent.shade100;

    final now = DateTime.now();
    final difference = endDate.difference(now).inDays;

    if (difference < 0) return Colors.redAccent.shade100;
    if (difference <= 7) return Colors.orangeAccent.shade100;
    return Colors.greenAccent.shade100;
  }

  // Navegar al detalle del contrato
  void _navigateToDetail(String contractId) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final contract = await _contractService.getContractById(contractId);

      if (mounted) Navigator.pop(context);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContractDetailPage(contract: contract),
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar contratos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _contractsFuture = _contractService.getContracts();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay contratos disponibles',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
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
                onTap: () => _navigateToDetail(contract.id),
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
  final Color Function(DateTime?) getExpiryColor;
  final String Function(DateTime?) getExpiryStatus;
  final VoidCallback onTap;

  const _AnimatedContractCard({
    Key? key,
    required this.contract,
    required this.isDark,
    required this.getStatusColor,
    required this.formatDate,
    required this.getExpiryColor,
    required this.getExpiryStatus,
    required this.onTap,
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
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
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
                    contract.title,
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
                    color: widget.getStatusColor(contract.estado),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    contract.estado.toUpperCase(),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: widget.getExpiryColor(contract.endDate),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.getExpiryStatus(contract.endDate),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 8),
            // Empleado
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: widget.isDark ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    contract.perfilEmpleado.fullName,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: widget.isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            // Fechas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inicio',
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                widget.isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        Text(
                          widget.formatDate(contract.startDate),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                widget.isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fin',
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                widget.isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        Text(
                          contract.endDate != null
                              ? widget.formatDate(contract.endDate!)
                              : 'Indefinido',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                widget.isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: widget.isDark ? Colors.white54 : Colors.black38,
                ),
              ],
            ),

            const SizedBox(height: 6),
            // Tipo de contrato
            Text(
              contract.tipoContrato.name,
              style: TextStyle(
                fontSize: 12,
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

// ============================================
// PÁGINA DE DETALLE DEL CONTRATO
// ============================================

class ContractDetailPage extends StatelessWidget {
  final Contract contract;

  const ContractDetailPage({Key? key, required this.contract})
      : super(key: key);

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Contrato'),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y Estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    contract.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(contract.estado),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    contract.estado.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Información del Empleado
            _buildSection(
              context,
              title: 'Información del Empleado',
              icon: Icons.person,
              children: [
                _buildInfoRow('Nombre', contract.perfilEmpleado.fullName),
                _buildInfoRow('Email', contract.perfilEmpleado.email),
                _buildInfoRow('Documento', contract.perfilEmpleado.document),
                if (contract.perfilEmpleado.numberPhone != null)
                  _buildInfoRow('Teléfono',
                      contract.perfilEmpleado.numberPhone.toString()),
              ],
            ),

            const SizedBox(height: 20),

            // Información del Creador
            _buildSection(
              context,
              title: 'Creado por',
              icon: Icons.business,
              children: [
                _buildInfoRow('Nombre', contract.perfilCreador.fullName),
                _buildInfoRow('Email', contract.perfilCreador.email),
              ],
            ),

            const SizedBox(height: 20),

            // Información del Contrato
            _buildSection(
              context,
              title: 'Detalles del Contrato',
              icon: Icons.description,
              children: [
                _buildInfoRow('Tipo', contract.tipoContrato.name),
                _buildInfoRow('Fecha Inicio', formatDate(contract.startDate)),
                _buildInfoRow(
                  'Fecha Fin',
                  contract.endDate != null
                      ? formatDate(contract.endDate!)
                      : 'Indefinido',
                ),
                _buildInfoRow('EPS', contract.eps),
                _buildInfoRow('ARL', contract.arl),
                _buildInfoRow('Estrato', contract.estrato.toString()),
              ],
            ),

            const SizedBox(height: 20),

            // Descripción del tipo de contrato
            _buildSection(
              context,
              title: 'Descripción del Tipo de Contrato',
              icon: Icons.info_outline,
              children: [
                Text(
                  contract.tipoContrato.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Contenido del Contrato
            _buildSection(
              context,
              title: 'Contenido del Contrato',
              icon: Icons.article,
              children: [
                Text(
                  contract.tipoContrato.content,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Información de la Vacante
            _buildSection(
              context,
              title: 'Vacante Asociada',
              icon: Icons.work,
              children: [
                _buildInfoRow('Título', contract.vacante.tittle),
                _buildInfoRow('Salario', contract.vacante.salary),
                _buildInfoRow('Horario', contract.vacante.horary),
                _buildInfoRow('Dirección', contract.vacante.address),
                _buildInfoRow('Teléfono', contract.vacante.telephone),
                _buildInfoRow('Email', contract.vacante.email),
                const SizedBox(height: 8),
                Text(
                  contract.vacante.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Firmas
            if (contract.firmaEmpleado != null ||
                contract.firmaEmpleador != null)
              _buildSection(
                context,
                title: 'Firmas',
                icon: Icons.gesture,
                children: [
                  // Firma del Empleado
                  Text(
                    'Firma del Empleado:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: (contract.firmaEmpleado != null &&
                            contract.firmaEmpleado!.isNotEmpty)
                        ? Image.memory(
                            Uri.parse(contract.firmaEmpleado!)
                                .data!
                                .contentAsBytes(),
                            fit: BoxFit.contain,
                          )
                        : Text(
                            'Sin firma',
                            style: TextStyle(color: Colors.grey),
                          ),
                  ),
                  const SizedBox(height: 16),

                  // Firma del Empleador
                  Text(
                    'Firma del Empleador:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: (contract.firmaEmpleador != null &&
                            contract.firmaEmpleador!.isNotEmpty)
                        ? Image.memory(
                            Uri.parse(contract.firmaEmpleador!)
                                .data!
                                .contentAsBytes(),
                            fit: BoxFit.contain,
                          )
                        : Text(
                            'Sin firma',
                            style: TextStyle(color: Colors.grey),
                          ),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // Fechas de creación y actualización
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Creado:',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Text(
                        formatDate(contract.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Actualizado:',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      Text(
                        formatDate(contract.updatedAt),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
