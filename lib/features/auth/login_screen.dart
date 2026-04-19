import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function() onLogin;
  final VoidCallback onOpenRegister;

  const LoginScreen({
    super.key,
    required this.onLogin,
    required this.onOpenRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
                const SizedBox(height: 72),
                Center(
                  child: Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2FD4CB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.ramen_dining, color: Color(0xFF063F43), size: 52),
                  ),
                ),
                const SizedBox(height: 56),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 42, fontWeight: FontWeight.w700, color: Color(0xFF2FD4CB)),
                ),
                const SizedBox(height: 20),
                _AuthInput(controller: _email, hint: 'Email', icon: Icons.mail_outline),
                const SizedBox(height: 12),
                _AuthInput(controller: _password, hint: 'Password', icon: Icons.lock_outline, obscure: true),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password', style: TextStyle(color: Color(0xFF2FD4CB), fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async => widget.onLogin(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2FD4CB),
                      foregroundColor: const Color(0xFF042A2F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  ),
                ),
                const SizedBox(height: 26),
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
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIcon(label: 'f', color: Color(0xFF1877F2)),
                    SizedBox(width: 18),
                    _SocialIcon(label: 'G', color: Color(0xFFDB4437)),
                    SizedBox(width: 18),
                    _SocialIcon(label: '', color: Colors.white),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Dont have an account? ', style: TextStyle(color: Colors.white70)),
                      GestureDetector(
                        onTap: widget.onOpenRegister,
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

class _AuthInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;

  const _AuthInput({required this.controller, required this.hint, required this.icon, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF38484D), width: 1.3),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          prefixIcon: Icon(icon, color: Colors.white70),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String label;
  final Color color;

  const _SocialIcon({required this.label, required this.color});

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
        child: Text(label, style: TextStyle(color: color, fontSize: 26, fontWeight: FontWeight.w800)),
      ),
    );
  }
}
