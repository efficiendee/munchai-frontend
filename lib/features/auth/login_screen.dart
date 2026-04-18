import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Future<void> Function() onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0E11), Color(0xFF13181F)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Text(
                  'munch.ai',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Dummy login for frontend flow',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 28),
                const TextField(decoration: InputDecoration(hintText: 'Email')),
                const SizedBox(height: 12),
                const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Password')),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async => onLogin(),
                  child: const Text('Login (Dummy)'),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
