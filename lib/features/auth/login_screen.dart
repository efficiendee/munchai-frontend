import 'package:flutter/material.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function() onLogin;
  final Future<void> Function() onRegister;

  const LoginScreen({super.key, required this.onLogin, required this.onRegister});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                const SizedBox(height: 70),
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
                const SizedBox(height: 56),
                const Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: Color(0xFF2FD4CB))),
                const SizedBox(height: 22),
                _InputField(controller: _email, hint: 'Email', icon: Icons.mail_outline),
                const SizedBox(height: 14),
                _InputField(controller: _password, hint: 'Password', icon: Icons.lock_outline, obscure: true),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password', style: TextStyle(color: Color(0xFF2FD4CB), fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async => widget.onLogin(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FD4CB),
                      foregroundColor: const Color(0xFF042A2F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(height: 28),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Color(0xFF4D5B60))),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Or login with', style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Color(0xFF4D5B60))),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    _SocialCircle(label: 'f', color: Color(0xFF1877F2)),
                    SizedBox(width: 22),
                    _SocialCircle(label: 'G', color: Color(0xFFDB4437)),
                    SizedBox(width: 22),
                    _SocialCircle(label: '', color: Colors.white),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? ', style: TextStyle(color: Colors.white70)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegisterScreen(onRegister: widget.onRegister),
                            ),
                          );
                        },
                        child: const Text('Sign Up', style: TextStyle(color: Color(0xFF2FD4CB), fontWeight: FontWeight.w700)),
                      ),
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

class _SocialCircle extends StatelessWidget {
  final String label;
  final Color color;

  const _SocialCircle({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2328),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 26)),
      ),
    );
  }
}
