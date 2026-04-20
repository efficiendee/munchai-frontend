import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              const SizedBox(height: 64),
              const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              const SizedBox(height: 44),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF152228),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF29363C)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2FD4CB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.ramen_dining, color: Color(0xFF063F43), size: 30),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Personalized recipes for you.', style: TextStyle(color: Colors.white70, fontSize: 16)),
                          SizedBox(height: 2),
                          Text('Hi, Jonas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          SizedBox(height: 2),
                          Text('Edit profile', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _SettingsRow(label: 'Switch Mode', onTap: () {}),
              const SizedBox(height: 8),
              _SettingsRow(label: 'My favorites', onTap: () {}),
              const SizedBox(height: 8),
              _SettingsRow(label: 'Language', onTap: () {}),
              const SizedBox(height: 8),
              _SettingsRow(label: 'Accessibility', onTap: () {}),
              const SizedBox(height: 8),
              _SettingsRow(label: 'History', onTap: () {}),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
                    label: const Text('Back'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SettingsRow({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF152228),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
