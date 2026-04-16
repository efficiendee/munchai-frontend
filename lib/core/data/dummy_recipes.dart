import '../models/recipe.dart';

const dummyRecipes = <Recipe>[
  Recipe(
    id: '1',
    title: 'Soy-Garlic Chicken Rice Bowl',
    image: 'assets/images/recipe1.png',
    matchScore: 95,
    minutes: 20,
    difficulty: 'Easy',
    ingredients: ['Chicken', 'Rice', 'Soy sauce', 'Garlic', 'Scallions'],
    steps: [
      'Cook rice and keep warm.',
      'Sear chicken strips for 6–8 min.',
      'Add garlic + soy sauce and glaze.',
      'Serve over rice, top with scallions.'
    ],
  ),
  Recipe(
    id: '2',
    title: 'Protein Pasta Bowl',
    image: 'assets/images/recipe2.png',
    matchScore: 88,
    minutes: 18,
    difficulty: 'Easy',
    ingredients: ['Pasta', 'Greek yogurt', 'Spinach', 'Parmesan'],
    steps: [
      'Boil pasta al dente.',
      'Mix yogurt with pasta water and parmesan.',
      'Fold in spinach and pasta.',
      'Season and plate.'
    ],
  ),
];
