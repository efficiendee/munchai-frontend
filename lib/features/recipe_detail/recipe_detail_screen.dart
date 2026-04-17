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
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.title),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(recipe.imageUrl, fit: BoxFit.cover),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x11000000), Color(0xCC000000)],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Match ${recipe.matchScore}% • ${recipe.minutes} min • ${recipe.difficulty}',
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 18),
                const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...recipe.ingredients.map((i) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('• $i'),
                    )),
                const SizedBox(height: 18),
                const Text('Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...recipe.steps.asMap().entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${e.key + 1}. ${e.value}'),
                    )),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () {}, child: const Text('Start Cooking Mode (soon)')),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
