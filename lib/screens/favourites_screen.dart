import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<String> favourites;
  const FavouritesScreen({
    super.key,
    required this.favourites,
  });

  @override
  Widget build(BuildContext context) {
    print(favourites);
    final favouriteMealList = DUMMY_MEALS
        .where(
          (meal) => favourites.contains(meal.id),
        )
        .toList();
    if (favouriteMealList.isEmpty) {
      return const Center(
        child: Text(
          'No favourite meals found. Start adding + some',
          // style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) => MealItem(
        key: ValueKey(favouriteMealList[index].id.toString()),
        id: favouriteMealList[index].id.toString(),
        title: favouriteMealList[index].title.toString(),
        imageUrl: favouriteMealList[index].imageUrl,
        duration: favouriteMealList[index].duration,
        complexity: favouriteMealList[index].complexity,
        affordability: favouriteMealList[index].affordability,
      ),
      itemCount: favouriteMealList.length,
    );
  }
}
