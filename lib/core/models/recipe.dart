class Recipe {
  final String id;
  final String title;
  final String image;
  final int matchScore;
  final int minutes;
  final String difficulty;
  final List<String> ingredients;
  final List<String> steps;

  const Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.matchScore,
    required this.minutes,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
  });
}
