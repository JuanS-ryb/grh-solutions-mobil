import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:grhsolutions/data/notifiers.dart';
import 'package:grhsolutions/models/user/login-model.dart';
import 'package:grhsolutions/services/user/login-services.dart';
import 'package:intl/intl.dart';
import '../../models/documentType/document_type_model.dart';
import '../../services/documentType/document_type_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void showLoginModal(Color bg) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4, // 60% pantalla
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 32,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 32,
                ),
                child: const LoginForm(),
              ),
            );
          },
        );
      },
    );
  }

  void showRegisterModal(Color bg) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 32,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 32,
                ),
                child: const RegisterForm(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,  // 👈 evita overflow
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => showLoginModal(theme.cardColor),
                  icon: Icon(Icons.login, color: theme.iconTheme.color),
                  label: Text("INGRESAR", style: theme.textTheme.bodyMedium),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => showRegisterModal(theme.cardColor),
                  icon: Icon(Icons.person_add, color: theme.iconTheme.color),
                  label: Text("REGISTRARSE", style: theme.textTheme.bodyMedium),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ------------------
/// FORMULARIO LOGIN
/// ------------------
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final LoginService loginServices = LoginService();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final loginResponse = await loginServices.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      debugPrint(
          'Response from endpoint --------------------- $loginResponse.toString()');
      isLoggedIn.value = true;
      loginController.value = loginResponse;

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint('Error from endpoint --------------------- $e.toString()');
      setState(() {
        _error = "Hubo un error al comunicarse con el servidor";
      });
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(
      valueListenable: isLoggedIn,
      builder: (context, loggedIn, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _loading ? null : handleLogin,
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Login', style: theme.textTheme.bodyMedium),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// ------------------
/// FORMULARIO REGISTRO
/// ------------------
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _firstLastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _docNumberController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  DateTime? _birthDate;
  List<DocumentType> _documentTypes = [];
  String? _selectedDocumentId;

  @override
  void initState() {
    super.initState();
    _loadDocumentTypes();
  }

  Future<void> _loadDocumentTypes() async {
    final service = DocumentService();
    try {
      final docs = await service.getDocumentTypes();
      setState(() {
        _documentTypes = docs;
      });
    } catch (e) {
      debugPrint("Error cargando tipos de documento: $e");
    }
  }

  DateTime _clampDate(DateTime date, DateTime min, DateTime max) {
    if (date.isBefore(min)) return min;
    if (date.isAfter(max)) return max;
    return date;
  }


  void _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
      locale: const Locale("es", "ES"),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final data = {
        "primerNombre": _firstNameController.text.trim(),
        "segundoNombre": _secondNameController.text.trim(),
        "primerApellido": _firstLastNameController.text.trim(),
        "segundoApellido": _secondLastNameController.text.trim(),
        "correo": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
        "tipoDocumento": _selectedDocumentId,
        "numeroDocumento": _docNumberController.text.trim(),
        "fechaNacimiento": _birthDate?.toIso8601String(),
      };

      debugPrint("Datos a registrar: $data");

      // Aquí haces tu request POST al backend
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Registrarse', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // Nombres
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'Primer Nombre', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _secondNameController,
                    decoration: const InputDecoration(labelText: 'Segundo Nombre', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Apellidos
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstLastNameController,
                    decoration: const InputDecoration(labelText: 'Primer Apellido', border: OutlineInputBorder()),
                    validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _secondLastNameController,
                    decoration: const InputDecoration(labelText: 'Segundo Apellido', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo Electrónico', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return "Campo requerido";
                final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
                return !regex.hasMatch(v) ? "Correo inválido" : null;
              },
            ),
            const SizedBox(height: 16),

            // Contraseña
            TextFormField(
              controller: _passwordController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                ),
              ),
              validator: (v) => v!.length < 6 ? "Mínimo 6 caracteres" : null,
            ),
            const SizedBox(height: 16),

            // Confirmar contraseña
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_confirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                ),
              ),
              validator: (v) => v != _passwordController.text ? "Las contraseñas no coinciden" : null,
            ),
            const SizedBox(height: 16),

            // Tipo de documento
            DropdownButtonFormField<String>(

              initialValue: _selectedDocumentId,
              decoration: const InputDecoration(
                labelText: "Tipo de Documento",
                border: OutlineInputBorder(),
              ),
              items: _documentTypes.map((doc) {
                return DropdownMenuItem<String>(

                  value: doc.id,
                  child: Text(doc.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDocumentId = value;
                });
              },
              validator: (value) =>
              value == null ? "Seleccione un tipo de documento" : null,
            ),
            const SizedBox(height: 16),

            // Número documento
            TextFormField(
              controller: _docNumberController,
              decoration: const InputDecoration(labelText: 'Número de documento', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Campo requerido" : null,
            ),
            const SizedBox(height: 16),

// Fecha nacimiento
            InkWell(
              onTap: () async {
                final today = DateTime.now();
                final minDate = DateTime(1900);
                // si ya tienes un _birthDate, lo aseguras dentro del rango; si no, úsalo por defecto en today
                final initial = _birthDate == null ? today : _clampDate(_birthDate!, minDate, today);

                final picked = await showDatePickerDialog(
                  context: context,
                  initialDate: initial,
                  minDate: minDate,
                  maxDate: today, // <-- evita fechas futuras dinámicamente
                  currentDateDecoration: const BoxDecoration(),
                  currentDateTextStyle: const TextStyle(),
                  daysOfTheWeekTextStyle: const TextStyle(),
                  disabledCellsTextStyle: const TextStyle(),
                  enabledCellsDecoration: const BoxDecoration(),
                  enabledCellsTextStyle: const TextStyle(),
                  initialPickerType: PickerType.days,
                  selectedCellDecoration: const BoxDecoration(),
                  selectedCellTextStyle: const TextStyle(),
                  leadingDateTextStyle: const TextStyle(),
                );

                if (picked != null) {
                  // validación extra por si acaso
                  if (picked.isAfter(today)) {
                    // nunca debería ocurrir porque maxDate = today, pero por seguridad:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No puede seleccionar una fecha futura')),
                    );
                    return;
                  }

                  setState(() {
                    _birthDate = picked;
                  });
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha de nacimiento',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _birthDate == null
                      ? "Seleccione una fecha"
                      : DateFormat("dd/MM/yyyy").format(_birthDate!),
                ),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _register,
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
