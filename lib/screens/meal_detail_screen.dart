import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const namedRoute = '/meal-detail';
  final Function setFavourite;
  final List<String> favourites;
  const MealDetailScreen(
      {super.key, required this.favourites, required this.setFavourite});

  Widget buildHeading(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget buildList(
    Widget child,
  ) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];

    // print(mealId);
    final foundMeal = DUMMY_MEALS.firstWhere(
      (meal) => meal.id == mealId,
    );

    final isMealFavourite = favourites.contains(foundMeal.id);

    // print(foundMeal);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          foundMeal.title,
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              foundMeal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            buildHeading(context, 'Ingredients'),
            buildList(
              ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Row(children: [
                            const Icon(Icons.arrow_right_rounded),
                            const SizedBox(
                              width: 6,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                              child: Text(foundMeal.ingredients[index]),
                            ),
                          ]),
                        ),
                      ),
                  itemCount: foundMeal.ingredients.length),
            ),
            buildHeading(context, 'Steps'),
            buildList(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('# ${index + 1}'),
                      ),
                      title: Text(foundMeal.steps[index]),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: foundMeal.steps.length,
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setFavourite(foundMeal.id),
        child: isMealFavourite
            ? const Icon(Icons.star_rate_rounded)
            : const Icon(Icons.star_outline_rounded),
      ),
    );
  }
}
