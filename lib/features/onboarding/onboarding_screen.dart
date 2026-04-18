import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  final Future<void> Function(String tasteProfile) onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  String _diet = 'Omnivore';
  final Set<String> _goals = {'Fast'};
  final Set<String> _allergens = {};

  Future<void> _next() async {
    if (_index < 2) {
      await _controller.nextPage(duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
    } else {
      final profile = 'diet=$_diet; goals=${_goals.join(",")}; allergens=${_allergens.join(",")}';
      await widget.onComplete(profile);
    }
  }

  Future<void> _back() async {
    if (_index > 0) {
      await _controller.previousPage(duration: const Duration(milliseconds: 220), curve: Curves.easeOut);
    }
  }

  Widget _frame(Widget child) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF03161B), Color(0xFF041419), Color(0xFF021015)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  if (_index > 0)
                    IconButton(onPressed: _back, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70))
                  else
                    const SizedBox(width: 48),
                  const Spacer(),
                  const Icon(Icons.tune_rounded, color: Color(0xFF2FD4CB)),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(child: child),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _index ? const Color(0xFF2FD4CB) : const Color(0xFF3F4B50),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FD4CB),
                    foregroundColor: const Color(0xFF042A2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(_index == 2 ? 'Finish' : 'Next', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        children: [
          _frame(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                const Text('Let\'s personalize\nyour feed', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Choose your diet preference', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ['Vegan', 'Vegetarian', 'Omnivore'].map((d) {
                    final selected = _diet == d;
                    return ChoiceChip(
                      label: Text(d),
                      selected: selected,
                      selectedColor: const Color(0xFF2FD4CB),
                      labelStyle: TextStyle(color: selected ? const Color(0xFF042A2F) : Colors.white),
                      backgroundColor: const Color(0xFF152228),
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _diet = d),
                    );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
          _frame(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                const Text('What\'s your goal?', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('This helps the app prioritize recipes', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ['Fast', 'High-protein', 'Budget-friendly', 'Low-carb', 'Comfort'].map((g) {
                    final selected = _goals.contains(g);
                    return FilterChip(
                      label: Text(g),
                      selected: selected,
                      selectedColor: const Color(0xFF2FD4CB),
                      labelStyle: TextStyle(color: selected ? const Color(0xFF042A2F) : Colors.white),
                      backgroundColor: const Color(0xFF152228),
                      showCheckmark: false,
                      onSelected: (s) => setState(() => s ? _goals.add(g) : _goals.remove(g)),
                    );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
          _frame(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 22),
                const Text('Allergens', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Select what should be excluded', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ['Gluten', 'Nuts', 'Lactose', 'Soy', 'Shellfish', 'Eggs', 'Fish'].map((a) {
                    final selected = _allergens.contains(a);
                    return FilterChip(
                      label: Text(a),
                      selected: selected,
                      selectedColor: const Color(0xFF2FD4CB),
                      labelStyle: TextStyle(color: selected ? const Color(0xFF042A2F) : Colors.white),
                      backgroundColor: const Color(0xFF152228),
                      showCheckmark: false,
                      onSelected: (s) => setState(() => s ? _allergens.add(a) : _allergens.remove(a)),
                    );
                  }).toList(),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
