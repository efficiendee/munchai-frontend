import '../models/recipe.dart';

const dummyRecipes = <Recipe>[
  Recipe(
    id: '1',
    title: 'Soy-Garlic Chicken Rice Bowl',
    imageUrl: 'assets/images/recipe1.png',
    matchScore: 95,
    minutes: 20,
    difficulty: 'Easy',
    tagline: 'Sweet umami comfort bowl',
    ingredients: ['300g chicken breast', '150g rice', '40ml soy sauce', '3 cloves garlic', '1 onion', 'carrot'],
    steps: [
      'Cook rice and keep warm.',
      'Sear chicken cubes for 6–8 min.',
      'Add garlic + soy sauce and glaze.',
      'Serve over rice with carrot and scallions.'
    ],
  ),
  Recipe(
    id: '2',
    title: 'Salmon Poke Bowl',
    imageUrl: 'assets/images/recipe2.png',
    matchScore: 88,
    minutes: 18,
    difficulty: 'Easy',
    tagline: 'Fresh and protein-rich',
    ingredients: ['Salmon', 'Rice', 'Cucumber', 'Avocado', 'Sesame'],
    steps: [
      'Cook and cool rice.',
      'Cube salmon and season lightly.',
      'Slice cucumber and avocado.',
      'Assemble bowl and finish with sesame.'
    ],
  ),
];
