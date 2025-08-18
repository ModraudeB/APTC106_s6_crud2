import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _error = null;
      });
      final url = dotenv.env['API_URL'] ?? 'http://10.0.2.2:8000/api/token/';
      final body = jsonEncode({
        'username': _userController.text.trim(),  // Trim para eliminar espacios
        'password': _passController.text.trim(),
      });
      print('URL: $url');  // Depura en consola
      print('Body enviado: $body');  // Depura en consola
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',  // Fuerza respuesta JSON
          },
          body: body,
        );
        print('Status: ${response.statusCode}');  // Depura
        print('Response body: ${response.body}');  // Depura
        if (response.statusCode == 200) {
          // Éxito: Parse y navega
          final data = jsonDecode(response.body);
          // Aquí puedes guardar tokens con shared_preferences si lo tienes
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const SuccessScreen()),
          );
        } else {
          // Error 400 u otros: Parse JSON si es posible
          try {
            final errorData = jsonDecode(response.body);
            setState(() {
              _error = errorData['detail'] ?? 'Error: ${response.body.substring(0, 100)}...';
            });
          } catch (_) {
            setState(() {
              _error = 'Error del servidor: ${response.body.substring(0, 100)}... (Status: ${response.statusCode})';
            });
          }
        }
      } catch (e) {
        print('Excepción: $e');  // Depura
        setState(() {
          _error = 'Error de conexión: $e';
        });
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FoodPlease Login'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', height: 150, width: 150),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    prefixIcon: const Icon(Icons.person, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Ingresa un usuario' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Ingresa una contraseña' : null,
                ),
                const SizedBox(height: 20),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                _loading
                    ? const CircularProgressIndicator(color: Colors.red)
                    : ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido'), backgroundColor: Colors.red),
      body: const Center(child: Text('Login exitoso', style: TextStyle(fontSize: 24))),
    );
  }
}