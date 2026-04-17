import 'package:flutter/material.dart';

import '../../core/data/app_scope.dart';
import '../../core/models/recipe.dart';
import '../recipe_detail/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _recipesFuture;
  double maxTime = 35;
  String mood = 'Any';

  @override
  void initState() {
    super.initState();
    _recipesFuture = AppScope.recipes.getRecommendations();
  }

  void _openFilters() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF14181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        double draftMaxTime = maxTime;
        String draftMood = mood;

        return StatefulBuilder(
          builder: (context, setModalState) => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Filters', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                  Text('Max cooking time: ${draftMaxTime.round()} min'),
                  Slider(
                    value: draftMaxTime,
                    min: 10,
                    max: 60,
                    onChanged: (v) => setModalState(() => draftMaxTime = v),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Any', 'Comfort', 'Fresh', 'Protein', 'Quick']
                        .map((m) => ChoiceChip(
                              label: Text(m),
                              selected: draftMood == m,
                              onSelected: (_) => setModalState(() => draftMood = m),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        maxTime = draftMaxTime;
                        mood = draftMood;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('munch.ai', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [IconButton(onPressed: _openFilters, icon: const Icon(Icons.tune))],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final recipes = snapshot.data!
              .where((r) => r.minutes <= maxTime)
              .where((r) => mood == 'Any' || (r.tagline ?? '').toLowerCase().contains(mood.toLowerCase()))
              .toList();

          if (recipes.isEmpty) {
            return const Center(child: Text('No recipes found for current filters.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            itemBuilder: (context, index) => _RecipeCard(recipe: recipes[index]),
          );
        },
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: DecorationImage(
            image: NetworkImage(recipe.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xD9000000), Color(0x33000000)],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(recipe.title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
              if (recipe.tagline != null) ...[
                const SizedBox(height: 4),
                Text(recipe.tagline!, style: const TextStyle(color: Colors.white70)),
              ],
              const SizedBox(height: 8),
              Text('Match ${recipe.matchScore}% • ${recipe.minutes} min • ${recipe.difficulty}'),
            ],
          ),
        ),
      ),
    );
  }
}
