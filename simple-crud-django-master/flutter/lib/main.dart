import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error al cargar .env: $e');
    // Aquí puedes agregar lógica adicional, como usar valores predeterminados o mostrar un error en la UI
  }
  runApp(const FoodPleaseApp());
}

class FoodPleaseApp extends StatelessWidget {
  const FoodPleaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodPlease',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
    );
  }
}