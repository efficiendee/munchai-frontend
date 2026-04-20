import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? Colors.white : const Color(0xFF0F1216);
    final muted = isDark ? Colors.white70 : const Color(0xFF4E5961);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 56,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_rounded, color: fg, size: 24),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border, color: fg, size: 24)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined, color: fg, size: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: fg)),
              const SizedBox(height: 24),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 140,
                      height: 140,
                      color: isDark ? const Color(0xFF172127) : const Color(0xFFE4EAEE),
                      child: Image.asset(
                        'assets/images/profile_dave.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Personalized recipes for you.', style: TextStyle(color: muted, fontSize: 16, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 18),
                        Text('Hi, Dave', style: TextStyle(color: fg, fontSize: 20, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.local_florist_outlined, size: 14, color: muted),
                            const SizedBox(width: 6),
                            Text('Edit profile', style: TextStyle(color: muted, fontSize: 14, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              _ModeRow(
                isDarkMode: isDarkMode,
                onChanged: onThemeChanged,
                fg: fg,
              ),
              const SizedBox(height: 6),
              _NavRow(icon: Icons.favorite_border, label: 'My favorites', fg: fg),
              _NavRow(icon: Icons.language, label: 'Language', fg: fg),
              _NavRow(icon: Icons.accessibility_new, label: 'Accessibility', fg: fg),
              _NavRow(icon: Icons.schedule, label: 'History', fg: fg),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeRow extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;
  final Color fg;

  const _ModeRow({required this.isDarkMode, required this.onChanged, required this.fg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Text('Dark Mode', style: TextStyle(color: fg, fontSize: 16, fontWeight: FontWeight.w400)),
          const Spacer(),
          GestureDetector(
            onTap: () => onChanged(!isDarkMode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 48,
              height: 28,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: isDarkMode ? const Color(0xFF2FD4CB) : const Color(0xFF9EA8AE),
              ),
              child: Align(
                alignment: isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color fg;

  const _NavRow({required this.icon, required this.label, required this.fg});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Icon(icon, color: fg, size: 24),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: fg, fontSize: 16, fontWeight: FontWeight.w400)),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded, color: fg, size: 18),
        ],
      ),
    );
  }
}
