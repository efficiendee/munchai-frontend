import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final Future<void> Function() onRegister;

  const RegisterScreen({super.key, required this.onRegister});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF03161B), Color(0xFF041419), Color(0xFF021015)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2FD4CB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.ramen_dining, color: Color(0xFF063F43), size: 56),
                  ),
                ),
                const SizedBox(height: 34),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w700, color: Color(0xFF2FD4CB)),
                ),
                const SizedBox(height: 18),
                _InputField(controller: _username, hint: 'Username', icon: Icons.person_outline),
                const SizedBox(height: 12),
                _InputField(controller: _email, hint: 'Email', icon: Icons.mail_outline),
                const SizedBox(height: 12),
                _InputField(controller: _password, hint: 'Password', icon: Icons.lock_outline, obscure: true),
                const SizedBox(height: 12),
                _InputField(controller: _confirm, hint: 'Confirm Password', icon: Icons.lock_reset_outlined, obscure: true),
                const SizedBox(height: 18),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async => widget.onRegister(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FD4CB),
                      foregroundColor: const Color(0xFF042A2F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Create Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: TextStyle(color: Colors.white70)),
                      Text('Login', style: TextStyle(color: Color(0xFF2FD4CB), fontWeight: FontWeight.w700)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;

  const _InputField({required this.controller, required this.hint, required this.icon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF38484D), width: 1.3),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white70),
        ),
      ),
    );
  }
}
