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
  final Set<String> _allergens = {};
  final Set<String> _goals = {'Fast'};

  static const _allergenOptions = ['Gluten', 'Crustaceans', 'Egg', 'Soy', 'Peanut', 'Fish', 'Dairy'];
  static const _goalOptions = ['Fast', 'Budget-friendly', 'Healthy', 'High-protein', 'Low-carb', 'Low-fat', 'High-fiber', 'Low -sugar'];

  Future<void> _next() async {
    if (_index < 2) {
      await _controller.nextPage(duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
      return;
    }

    final profile = 'diet=$_diet; allergens=${_allergens.join(',')}; goals=${_goals.join(',')}';
    await widget.onComplete(profile);
  }

  Future<void> _back() async {
    if (_index > 0) {
      await _controller.previousPage(duration: const Duration(milliseconds: 220), curve: Curves.easeOut);
    }
  }

  Widget _shell({required Widget child, required String ctaLabel}) {
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: _index > 0 ? _back : null,
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: _index > 0 ? Colors.white70 : Colors.transparent),
                  ),
                  const Spacer(),
                ],
              ),
              Expanded(child: child),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FD4CB),
                    foregroundColor: const Color(0xFF042A2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(ctaLabel, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dietPage() {
    return _shell(
      ctaLabel: 'Next',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          const Text('What’s your diet?', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Select one. You can change this anytime.', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 18),
          _dietCard(
            title: 'Omnivore',
            subtitle: 'All foods included! You eat everything.',
            image: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
          ),
          _dietCard(
            title: 'Vegetarian',
            subtitle: 'Plant-based, with dairy/eggs allowed.',
            image: 'https://images.unsplash.com/photo-1512058564366-c9e7b02f8bc7?w=400',
          ),
          _dietCard(
            title: 'Vegan',
            subtitle: '100% plant-based.',
            image: 'https://images.unsplash.com/photo-1547592180-85f173990554?w=400',
          ),
          _dietCard(
            title: 'Pescetarian',
            subtitle: 'Plant-based, with fish and seafood allowed.',
            image: 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=400',
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _dietCard({required String title, required String subtitle, required String image}) {
    final selected = _diet == title;
    return GestureDetector(
      onTap: () => setState(() => _diet = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF162329),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? const Color(0xFF2FD4CB) : const Color(0xFF29363C), width: 1.4),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(13), bottomLeft: Radius.circular(13)),
              child: Image.network(
                image,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 88,
                  height: 88,
                  color: const Color(0xFF223239),
                  child: const Icon(Icons.fastfood, color: Color(0xFF2FD4CB)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allergenPage() {
    return _shell(
      ctaLabel: 'Next',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          const Text('Any allergens?', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Mark anything to avoid. We’ll remove those ingredients and suggest swaps.', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _allergenOptions.map((a) {
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
    );
  }

  Widget _goalsPage() {
    return _shell(
      ctaLabel: 'Let’s cook!',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          const Text('What are your goals?', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Choose up to 3 priorities to shape your recipes.', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _goalOptions.map((g) {
              final selected = _goals.contains(g);
              return FilterChip(
                label: Text(g),
                selected: selected,
                selectedColor: const Color(0xFF2FD4CB),
                labelStyle: TextStyle(color: selected ? const Color(0xFF042A2F) : Colors.white),
                backgroundColor: const Color(0xFF152228),
                showCheckmark: false,
                onSelected: (s) {
                  setState(() {
                    if (s) {
                      if (_goals.length < 3) _goals.add(g);
                    } else {
                      _goals.remove(g);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (i) => setState(() => _index = i),
        children: [_dietPage(), _allergenPage(), _goalsPage()],
      ),
    );
  }
}
