import 'dummy_recipe_repository.dart';
import 'recipe_repository.dart';

class AppScope {
  // Backend-ready switch point (replace with ApiRecipeRepository later)
  static final RecipeRepository recipes = DummyRecipeRepository();
}
