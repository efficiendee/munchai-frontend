class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final int matchScore;
  final int minutes;
  final String difficulty;
  final List<String> ingredients;
  final List<String> steps;
  final String? tagline;

  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.matchScore,
    required this.minutes,
    required this.difficulty,
    required this.ingredients,
    required this.steps,
    this.tagline,
  });
}
