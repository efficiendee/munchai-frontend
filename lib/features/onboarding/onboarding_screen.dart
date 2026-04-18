import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final Future<void> Function(String tasteProfile) onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const _frames = [
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png',
    'assets/images/onboarding4.png',
  ];

  Future<void> _nextOrFinish() async {
    if (_index < _frames.length - 1) {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
      );
      return;
    }

    final tasteProfile = await _openTasteProfileSheet();
    if (tasteProfile != null && tasteProfile.trim().isNotEmpty) {
      await widget.onComplete(tasteProfile.trim());
    }
  }

  Future<String?> _openTasteProfileSheet() async {
    final textController = TextEditingController();
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151A22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Taste profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Beschreibe kurz deinen Geschmack (z. B. umami, spicy, high-protein).',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: textController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'z. B. Umami, scharf, schnelle Gerichte, asiatisch…',
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, textController.text),
                child: const Text('Finish onboarding'),
              ),
            ],
          ),
        );
      },
    );
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
              child: PageView.builder(
                controller: _controller,
                itemCount: _frames.length,
                onPageChanged: (value) => setState(() => _index = value),
                itemBuilder: (context, i) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(_frames[i], fit: BoxFit.cover),
                      // invisible clickable hotspot for the original primary CTA area
                      Positioned(
                        left: 24,
                        right: 24,
                        bottom: 64,
                        child: SizedBox(
                          height: 48,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _nextOrFinish,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
