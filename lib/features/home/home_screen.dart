import 'package:flutter/material.dart';

import '../recipe_detail/recipe_detail_screen.dart';
import '../../core/data/dummy_recipes.dart';
import 'camera_capture_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _ingredients = ['Tomaten', 'Eier', 'Spinat'];

  Future<void> _openCamera() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CameraCaptureScreen()),
    );
  }

  Future<void> _openManualEntry() async {
    final controller = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF151A22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Lebensmittel manuell hinzufügen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'z. B. Paprika, Reis, Joghurt'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final value = controller.text.trim();
                  if (value.isNotEmpty) {
                    setState(() => _ingredients.add(value));
                  }
                  Navigator.pop(context);
                },
                child: const Text('Hinzufügen'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1216),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 48,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SettingsScreen()),
                          ),
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.menu, color: Colors.white),
                        ),
                        const Spacer(),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2FD4CB),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.ramen_dining, color: Color(0xFF063F43)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 255),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Whats in your fridge?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: SizedBox(
                      width: 195,
                      child: Text(
                        'Add your ingredients, choose filters, or get inspired',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: _ingredients
                          .map(
                            (e) => Chip(
                              label: Text(e),
                              backgroundColor: const Color(0xFF152228),
                              side: const BorderSide(color: Color(0xFF2A3A40)),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Recent Recipes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white70)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dummyRecipes.length,
                      itemBuilder: (context, index) {
                        final recipe = dummyRecipes[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: recipe)),
                          ),
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Text(recipe.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                  width: 224,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF131A20),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFF263038)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _openCamera,
                        icon: const Icon(Icons.photo_camera_rounded, color: Colors.white),
                      ),
                      Container(width: 1, height: 24, color: const Color(0xFF33414A)),
                      IconButton(
                        onPressed: _openManualEntry,
                        icon: const Icon(Icons.edit_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
