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

  bool _acceptedTerms = false;
  bool _acceptedPersonalization = false;

  String _diet = 'Omnivore';
  final Set<String> _allergens = {};
  final Set<String> _goals = {'Fast'};

  static const _allergenOptions = ['Gluten', 'Crustaceans', 'Egg', 'Soy', 'Peanut', 'Fish', 'Dairy'];
  static const _goalOptions = ['Fast', 'Budget-friendly', 'Healthy', 'High-protein', 'Low-carb', 'Low-fat', 'High-fiber', 'Low -sugar'];

  Future<void> _next() async {
    if (_index == 0 && !(_acceptedTerms && _acceptedPersonalization)) return;

    if (_index < 3) {
      await _controller.nextPage(duration: const Duration(milliseconds: 240), curve: Curves.easeOut);
      return;
    }

    final profile =
        'diet=$_diet; allergens=${_allergens.join(',')}; goals=${_goals.join(',')}; acceptedTerms=$_acceptedTerms; acceptedPersonalization=$_acceptedPersonalization';
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
                  onPressed: (_index == 0 && !(_acceptedTerms && _acceptedPersonalization)) ? null : _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2FD4CB),
                    disabledBackgroundColor: const Color(0xFF1D4144),
                    foregroundColor: const Color(0xFF042A2F),
                    disabledForegroundColor: const Color(0xFF9AB7B6),
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

  Widget _welcomePage() {
    return _shell(
      ctaLabel: 'Start setup!',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF2FD4CB),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.ramen_dining, color: Color(0xFF063F43), size: 30),
            ),
          ),
          const SizedBox(height: 48),
          const Text('Hi, welcome to Y.AI', style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text(
            'Personalized recipes that fit your diet, time, budget, and what’s in your kitchen.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 22),
          _consentRow(
            checked: _acceptedTerms,
            onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
            text: 'I’ve read and agree to the Privacy Policy and Terms.',
          ),
          const SizedBox(height: 12),
          _consentRow(
            checked: _acceptedPersonalization,
            onTap: () => setState(() => _acceptedPersonalization = !_acceptedPersonalization),
            text: 'I consent to my data being used to personalize recommendations. I can withdraw consent anytime in Settings.',
          ),
          const SizedBox(height: 18),
          const Text(
            'Allergens are hard filters; everything else just improves ranking. You’re in control.',
            style: TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.45),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _consentRow({required bool checked, required VoidCallback onTap, required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: checked ? const Color(0xFF2FD4CB) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: checked ? const Color(0xFF2FD4CB) : const Color(0xFF4D5B60), width: 1.5),
            ),
            child: checked ? const Icon(Icons.check, size: 16, color: Color(0xFF042A2F)) : null,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.4))),
        ],
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
        children: [_welcomePage(), _dietPage(), _allergenPage(), _goalsPage()],
      ),
    );
  }
}
