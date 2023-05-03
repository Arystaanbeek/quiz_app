import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _email = '';
  String _password = '';

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      // Handle login success
      _onLoginSuccess();
    } on FirebaseAuthException catch (e) {
      // Handle login failure
      String errorMessage = 'Error logging in. Please try again.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Please try again.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(errorMessage),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _onLoginSuccess() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _onForgotPassword() {
    // Handle forgot password logic
    _onForgotPasswordSuccess();
  }

  void _onForgotPasswordSuccess() {
    Navigator.pushNamed(context, '/forgot_password');
  }

  void _onRegister() {
    // Handle register logic
    _onRegisterSuccess();
  }

  void _onRegisterSuccess() {
    Navigator.pushNamed(context, '/registration');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(labelText: 'Пароль'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Войти'),
            ),
            TextButton(
              onPressed: _onForgotPassword,
              child: const Text('Забыли пароль?'),
            ),
            TextButton(
              onPressed: _onRegister,
              child: const Text('Создать аккаунт'),
            ),
          ],
        ),
      ),
    );
  }
}
