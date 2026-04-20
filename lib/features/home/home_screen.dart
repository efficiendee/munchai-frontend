import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../recipe_detail/recipe_detail_screen.dart';
import '../../core/data/dummy_recipes.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _ingredients = ['Tomaten', 'Eier', 'Spinat'];
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _openCamera() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 88,
      );

      if (!mounted) return;

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Keine Aufnahme ausgewählt.')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto erfolgreich aufgenommen.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kamera konnte nicht geöffnet werden. Prüfe Berechtigungen.')),
      );
    }
  }

  Future<void> _openManualEntry() async {
    final controller = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sheetBg = isDark ? const Color(0xFF151A22) : const Color(0xFFF4F7F8);
    final fg = isDark ? Colors.white : const Color(0xFF0F1216);
    final muted = isDark ? Colors.white70 : const Color(0xFF4E5961);
    final fieldBg = isDark ? const Color(0xFF1A2328) : Colors.white;
    final fieldBorder = isDark ? const Color(0xFF33414A) : const Color(0xFFD1DAE0);

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: sheetBg,
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
              Text(
                'Lebensmittel manuell hinzufügen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: fg),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                style: TextStyle(color: fg),
                decoration: InputDecoration(
                  hintText: 'z. B. Paprika, Reis, Joghurt',
                  hintStyle: TextStyle(color: muted),
                  filled: true,
                  fillColor: fieldBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF2FD4CB), width: 1.3),
                  ),
                ),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? Colors.white : const Color(0xFF0F1216);
    final muted = isDark ? Colors.white70 : const Color(0xFF4E5961);
    final chipBg = isDark ? const Color(0xFF152228) : const Color(0xFFE4EAEE);
    final chipBorder = isDark ? const Color(0xFF2A3A40) : const Color(0xFFD1DAE0);
    final bottomBg = isDark ? const Color(0xFF131A20) : Colors.white;
    final bottomBorder = isDark ? const Color(0xFF263038) : const Color(0xFFD1DAE0);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            MaterialPageRoute(
                              builder: (_) => SettingsScreen(
                                isDarkMode: widget.isDarkMode,
                                onThemeChanged: widget.onThemeChanged,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.menu, color: fg),
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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Whats in your fridge?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: fg),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: SizedBox(
                      width: 195,
                      child: Text(
                        'Add your ingredients, choose filters, or get inspired',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: muted, height: 1.5, fontSize: 16),
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
                              label: Text(e, style: TextStyle(color: fg)),
                              backgroundColor: chipBg,
                              side: BorderSide(color: chipBorder),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Recent Recipes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: muted)),
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
                    color: bottomBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: bottomBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _openCamera,
                        icon: Icon(Icons.photo_camera_rounded, color: fg),
                      ),
                      Container(width: 1, height: 24, color: bottomBorder),
                      IconButton(
                        onPressed: _openManualEntry,
                        icon: Icon(Icons.edit_rounded, color: fg),
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
