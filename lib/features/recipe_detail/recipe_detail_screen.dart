import 'package:flutter/material.dart';

import '../../core/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(recipe.imageUrl, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x11000000), Color(0xCC000000)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.tagline ?? '', style: const TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _Tag('Omnivore'),
                      _Tag('Fast, High-protein'),
                      _Tag('< 30 min'),
                      _Tag('Less than 10€'),
                      _Tag('Lunch/Dinner'),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text('Servings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C2229),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text('2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 22),
                  const Text('Ingredients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...recipe.ingredients.map((i) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(i, style: const TextStyle(fontSize: 16)),
                      )),
                  const SizedBox(height: 22),
                  const Text('It’s a match!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('${recipe.matchScore}%', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 22),
                  const Text('Nutrition per serving', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Nutri('Cal', '540'),
                      _Nutri('Fat', '18g'),
                      _Nutri('Protein', '41g'),
                      _Nutri('Carbs', '50g'),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text('Smart substitutions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const _SubstitutionCard('What about a veggie option?', '300g chicken breast', '300g tofu'),
                  const SizedBox(height: 10),
                  const _SubstitutionCard('Need it faster?', '150g rice', '150g couscous'),
                  const SizedBox(height: 24),
                  ElevatedButton(onPressed: () {}, child: const Text('Start Cooking-Mode')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1D232A),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}

class _Nutri extends StatelessWidget {
  final String label;
  final String value;
  const _Nutri(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _SubstitutionCard extends StatelessWidget {
  final String title;
  final String oldV;
  final String newV;

  const _SubstitutionCard(this.title, this.oldV, this.newV);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F25),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text('$oldV → $newV', style: const TextStyle(color: Colors.white70)),
      ]),
    );
  }
}
