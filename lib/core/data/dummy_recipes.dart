import '../models/recipe.dart';

const dummyRecipes = <Recipe>[
  Recipe(
    id: '1',
    title: 'Soy-Garlic Chicken Rice Bowl',
    imageUrl:
        'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=1400&q=80',
    matchScore: 95,
    minutes: 20,
    difficulty: 'Easy',
    tagline: 'Sweet umami comfort bowl',
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
    imageUrl:
        'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=1400&q=80',
    matchScore: 88,
    minutes: 18,
    difficulty: 'Easy',
    tagline: 'Fast post-work fuel',
    ingredients: ['Pasta', 'Greek yogurt', 'Spinach', 'Parmesan'],
    steps: [
      'Boil pasta al dente.',
      'Mix yogurt with pasta water and parmesan.',
      'Fold in spinach and pasta.',
      'Season and plate.'
    ],
  ),
];
