import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'isGluten': false,
    'isLactose': false,
    'isVegan': false,
    'isVegetarian': false
  };

  final List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      _availableMeals.where((meal) {
        if (_filter['isGluten']! && meal.isGlutenFree) return false;
        if (_filter['isLactose']! && !meal.isLactoseFree) return false;
        if (_filter['isVegan']! && !meal.isVegan) return false;
        if (_filter['isVegetarian']! && !meal.isVegetarian) return false;
        return true;
      }).toList();

      print(_availableMeals.map((e) => e.title).toList());
    });
  }

  List<String> _favourites = [];
  void _toogleFavourite(String id) {
    setState(() {
      final existingFavourite = _favourites.indexOf(id);
      if (existingFavourite >= 0) {
        _favourites.remove(id);
      } else {
        _favourites.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
          primary: Colors.pink,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        // fontFamily: 'RobotoCondensed',
        primaryTextTheme: ThemeData.light().primaryTextTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'Raleway',
              ),
            ),

        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyMedium: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleSmall: const TextStyle(
                // fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(favourites: _favourites),
      routes: {
        CategoryMealsScreen.namedRoute: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.namedRoute: (ctx) => MealDetailScreen(
            favourites: _favourites, setFavourite: _toogleFavourite),
        FilterScreen.namedRoute: (ctx) => FilterScreen(
              filters: _filter,
              setFilter: _setFilters,
            ),
      },
    );
  }
}
