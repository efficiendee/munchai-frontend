import 'package:flutter/material.dart';

import '../../core/data/app_scope.dart';
import '../../core/models/recipe.dart';
import '../../core/theme/app_colors.dart';
import '../recipe_detail/recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _recipesFuture;
  double maxTime = 35;
  String selectedCategory = 'Breakfast';

  final categories = const ['Breakfast', 'Summer', 'Chinese Food', 'Umami'];

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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => maxTime = draftMaxTime);
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
      body: SafeArea(
        child: FutureBuilder<List<Recipe>>(
          future: _recipesFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            final recipes = snapshot.data!.where((r) => r.minutes <= maxTime).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 12, 8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('Find your next\nfavorite meal',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, height: 1.2)),
                      ),
                      IconButton(onPressed: _openFilters, icon: const Icon(Icons.tune_rounded, size: 28))
                    ],
                  ),
                ),
                SizedBox(
                  height: 46,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) {
                      final c = categories[i];
                      final selected = c == selectedCategory;
                      return ChoiceChip(
                        label: Text(c),
                        selected: selected,
                        onSelected: (_) => setState(() => selectedCategory = c),
                        selectedColor: AppColors.accent,
                        labelStyle: TextStyle(
                          color: selected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        backgroundColor: AppColors.surfaceSoft,
                        side: BorderSide.none,
                        showCheckmark: false,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemCount: categories.length,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) => _RecipeCard(recipe: recipes[index]),
                  ),
                ),
                const _BottomNav(),
              ],
            );
          },
        ),
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
        height: 248,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(recipe.imageUrl, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xE6000000), Color(0x22000000)],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(recipe.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text('Match ${recipe.matchScore}% • ${recipe.minutes} min • ${recipe.difficulty}',
                    style: const TextStyle(fontSize: 14)),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xEE171B20),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home_filled, color: AppColors.accent),
          Icon(Icons.camera_alt_rounded, color: Colors.white70),
          Icon(Icons.bookmark_rounded, color: Colors.white70),
          Icon(Icons.settings_rounded, color: Colors.white70),
        ],
      ),
    );
  }
}
