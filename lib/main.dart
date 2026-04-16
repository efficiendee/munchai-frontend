import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

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
      home: const HomeScreen(),
    );
  }
}
