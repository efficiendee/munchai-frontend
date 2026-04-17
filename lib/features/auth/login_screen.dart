import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B0E11), Color(0xFF101419)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const _Logo(),
                const SizedBox(height: 20),
                const Text('munch.ai',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                const Text('Your AI recipe companion',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 30),
                const TextField(decoration: InputDecoration(hintText: 'Email')),
                const SizedBox(height: 12),
                const TextField(obscureText: true, decoration: InputDecoration(hintText: 'Password')),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                  ),
                  child: const Text('Sign in (Dummy)'),
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

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.asset('assets/images/figma_logo.png', width: 96, height: 96, fit: BoxFit.cover),
      ),
    );
  }
}
