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
    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
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
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24),
                    ),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: Colors.white, size: 24)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, color: Colors.white, size: 24)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFF172127),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    const SizedBox(width: 24),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Personalized recipes for you.', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w400)),
                          SizedBox(height: 18),
                          Text('Hi, Jonas', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.local_florist_outlined, size: 14, color: Colors.white70),
                              SizedBox(width: 6),
                              Text('Edit profile', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _ModeRow(
                isDarkMode: isDarkMode,
                onChanged: onThemeChanged,
              ),
              const SizedBox(height: 6),
              const _NavRow(icon: Icons.favorite_border, label: 'My favorites'),
              const _NavRow(icon: Icons.language, label: 'Language'),
              const _NavRow(icon: Icons.accessibility_new, label: 'Accessibility'),
              const _NavRow(icon: Icons.schedule, label: 'History'),
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

  const _ModeRow({required this.isDarkMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const Text('Switch Mode', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
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

  const _NavRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}
