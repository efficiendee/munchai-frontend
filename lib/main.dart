import 'package:flutter/material.dart';

import 'core/storage/app_prefs.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MunchAiApp());
}

class MunchAiApp extends StatelessWidget {
  const MunchAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'munch.ai',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const _AppGate(),
    );
  }
}

class _AppGate extends StatefulWidget {
  const _AppGate();

  @override
  State<_AppGate> createState() => _AppGateState();
}

class _AppGateState extends State<_AppGate> {
  bool _loading = true;
  bool _loggedIn = false;
  bool _onboardingDone = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _loggedIn = await AppPrefs.isLoggedIn();
    _onboardingDone = await AppPrefs.isOnboardingDone();
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _login() async {
    await AppPrefs.setLoggedIn(true);
    setState(() => _loggedIn = true);
  }

  Future<void> _register() async {
    await AppPrefs.setLoggedIn(true);
    await AppPrefs.setOnboardingDone(false);
    setState(() {
      _loggedIn = true;
      _onboardingDone = false;
    });
  }

  Future<void> _finishOnboarding(String tasteProfile) async {
    await AppPrefs.setTasteProfile(tasteProfile);
    await AppPrefs.setOnboardingDone(true);
    setState(() => _onboardingDone = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_loggedIn) {
      return LoginScreen(onLogin: _login, onRegister: _register);
    }

    if (!_onboardingDone) {
      return OnboardingScreen(onComplete: _finishOnboarding);
    }

    return const HomeScreen();
  }
}
