import '../models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecommendations();
  Future<Recipe?> getRecipeById(String id);
}
