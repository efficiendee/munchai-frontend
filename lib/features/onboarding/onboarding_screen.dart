import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final Future<void> Function(String tasteProfile) onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;

  static const _frames = [
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
    'assets/images/onboarding4.png',
  ];

  Future<void> _advance() async {
    if (_index < _frames.length - 1) {
      setState(() => _index += 1);
      return;
    }

    // Prototype taste-profile placeholder value (flow-ready for backend hookup).
    await widget.onComplete('onboarding-prototype-profile');
  }

  Future<void> _back() async {
    if (_index > 0) {
      setState(() => _index -= 1);
    }
  }

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
                  Image.asset(_frames[_index], fit: BoxFit.cover),

                  // Primary CTA hotspot (bottom button area from Figma)
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 56,
                    height: 50,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _advance,
                    ),
                  ),

                  // Back arrow hotspot for screens 3/4 where arrow exists in Figma header
                  if (_index > 0)
                    Positioned(
                      left: 24,
                      top: 56,
                      width: 32,
                      height: 32,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _back,
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
