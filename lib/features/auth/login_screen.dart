import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final Future<void> Function() onLogin;

  const LoginScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Center(
            child: AspectRatio(
              aspectRatio: 390 / 845,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/onboarding1.png', fit: BoxFit.cover),

                  // Login button hotspot (from Figma layout)
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 553,
                    height: 50,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async => onLogin(),
                    ),
                  ),

                  // Optional social login hotspots (prototype-only)
                  Positioned(
                    left: 74,
                    top: 666,
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async => onLogin(),
                    ),
                  ),
                  Positioned(
                    left: 171,
                    top: 666,
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async => onLogin(),
                    ),
                  ),
                  Positioned(
                    left: 268,
                    top: 666,
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async => onLogin(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
