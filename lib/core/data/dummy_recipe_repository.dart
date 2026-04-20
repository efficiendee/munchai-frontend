import '../models/recipe.dart';
import 'dummy_recipes.dart';
import 'recipe_repository.dart';

class DummyRecipeRepository implements RecipeRepository {
  @override
  Future<List<Recipe>> getRecommendations() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return dummyRecipes;
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    try {
      return dummyRecipes.firstWhere((r) => r.id == id);
    } catch (_) {
      return null;
    }
  }
}
