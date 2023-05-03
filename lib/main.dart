import 'package:flutter/material.dart';
import './screens/auth_screen.dart';
import './screens/home_screen.dart';
import './screens/forgot_password_screen.dart';
import './screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth', // Устанавливаем страницу авторизации как начальную
      routes: {
        '/auth': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/registration': (context) => RegistrationScreen(),
      },
    );
  }
}
