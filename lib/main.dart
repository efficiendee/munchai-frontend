import 'package:flutter/material.dart';

import 'core/storage/app_prefs.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
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
  bool _showRegister = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Dev mode behavior requested by Dave:
    // - Always show login after app restart
    // - Always show onboarding after login (every app run)
    await AppPrefs.setLoggedIn(false);
    await AppPrefs.setOnboardingDone(false);

    _loggedIn = false;
    _onboardingDone = false;

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _login() async {
    await AppPrefs.setLoggedIn(true);
    setState(() {
      _loggedIn = true;
      _showRegister = false;
    });
  }

  Future<void> _register() async {
    await AppPrefs.setLoggedIn(true);
    await AppPrefs.setOnboardingDone(false);
    setState(() {
      _loggedIn = true;
      _onboardingDone = false;
      _showRegister = false;
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
      if (_showRegister) {
        return RegisterScreen(
          onRegister: _register,
          onBackToLogin: () => setState(() => _showRegister = false),
        );
      }
      return LoginScreen(
        onLogin: _login,
        onOpenRegister: () => setState(() => _showRegister = true),
      );
    }

    if (!_onboardingDone) {
      return OnboardingScreen(onComplete: _finishOnboarding);
    }

    return const HomeScreen();
  }
}
