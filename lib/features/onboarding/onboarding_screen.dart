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
      appBar: AppBar(title: const Text('Welcome to munch.ai')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('1) Dietary Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: diets
                .map(
                  (d) => ChoiceChip(
                    label: Text(d),
                    selected: _diet == d,
                    onSelected: (_) => setState(() => _diet = d),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text('2) Allergens (hard filters)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: allergens
                .map(
                  (a) => FilterChip(
                    label: Text(a),
                    selected: _allergens.contains(a),
                    onSelected: (selected) => setState(() {
                      selected ? _allergens.add(a) : _allergens.remove(a);
                    }),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text('3) Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: goals
                .map(
                  (g) => FilterChip(
                    label: Text(g),
                    selected: _goals.contains(g),
                    onSelected: (selected) => setState(() {
                      selected ? _goals.add(g) : _goals.remove(g);
                    }),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: const Text('Continue to Recipes'),
          ),
        ],
      ),
    );
  }
}
