import 'package:flutter/material.dart';
import 'login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(FoodPleaseApp());
}

class FoodPleaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodPlease',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
    );
  }
}

STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]
