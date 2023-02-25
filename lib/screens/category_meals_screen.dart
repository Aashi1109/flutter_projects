import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const namedRoute = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen({super.key, required this.availableMeals});

  // final String id;
  // final String categoryTitle;
  // const CategoryMealsScreen(
  //     {super.key, required this.id, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    final namedArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = namedArgs['title'];
    final categoryId = namedArgs['id'];
    final categoryMeals = availableMeals
        .where(
          (meal) => meal.categories.contains(categoryId),
        )
        .toList();
    return Scaffold(
        appBar: AppBar(
            title: Text(
          categoryTitle!,
          style: Theme.of(context).primaryTextTheme.titleLarge,
        )),
        body: ListView.builder(
          itemBuilder: (ctx, index) => MealItem(
            key: ValueKey(categoryMeals[index].id.toString()),
            id: categoryMeals[index].id.toString(),
            title: categoryMeals[index].title.toString(),
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          ),
          itemCount: categoryMeals.length,
        ));
  }
}
