import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String _diet = 'Omnivore';
  final Set<String> _allergens = <String>{};
  final Set<String> _goals = <String>{'Fast'};

  static const diets = ['Vegan', 'Vegetarian', 'Omnivore'];
  static const allergens = ['Gluten', 'Nuts', 'Lactose', 'Soy'];
  static const goals = ['Budget-friendly', 'High-protein', 'Fast'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup your taste profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Diet',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: diets
                  .map((d) => ChoiceChip(
                        label: Text(d),
                        selected: _diet == d,
                        onSelected: (_) => setState(() => _diet = d),
                      ))
                  .toList(),
            ),
          ),
          _Section(
            title: 'Allergens (hard filter)',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allergens
                  .map((a) => FilterChip(
                        label: Text(a),
                        selected: _allergens.contains(a),
                        onSelected: (selected) => setState(() {
                          selected ? _allergens.add(a) : _allergens.remove(a);
                        }),
                      ))
                  .toList(),
            ),
          ),
          _Section(
            title: 'Goals',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: goals
                  .map((g) => FilterChip(
                        label: Text(g),
                        selected: _goals.contains(g),
                        onSelected: (selected) => setState(() {
                          selected ? _goals.add(g) : _goals.remove(g);
                        }),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
            child: const Text('Continue'),
          )
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0x441B2026),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        child,
      ]),
    );
  }
}
