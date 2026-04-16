import 'package:flutter/material.dart';

import '../../core/data/dummy_recipes.dart';
import '../recipe_detail/recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('munch.ai'),
        actions: const [Padding(
          padding: EdgeInsets.only(right: 16),
          child: Icon(Icons.tune),
        )],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyRecipes.length,
        itemBuilder: (context, index) {
          final recipe = dummyRecipes[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RecipeDetailScreen(recipe: recipe),
              ),
            ),
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recipe.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text('Match ${recipe.matchScore}% • ${recipe.minutes} min • ${recipe.difficulty}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
