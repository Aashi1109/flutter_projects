import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const namedRoute = 'filter-meals';
  Map<String, bool> filters;
  Function setFilter;
  FilterScreen({super.key, required this.filters, required this.setFilter});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGluten = false;
  var _isLactose = false;
  var _isVegan = false;
  var _isVegetarian = false;

  Widget buildSwitchListTile(
      bool currentValue, String title, dynamic changeHandler) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text('Select if the food is $title'),
      onChanged: changeHandler,
    );
  }

  void _saveFilter() {
    // widget
    widget.setFilter({
      'isGluten': _isGluten,
      'isLactose': _isLactose,
      'isVegan': _isVegan,
      'isVegetarian': _isVegetarian,
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _isGluten = widget.filters['isGluten'] as bool;
    _isLactose = widget.filters['isLactose'] as bool;
    _isVegan = widget.filters['isVegan'] as bool;
    _isVegetarian = widget.filters['isVegetarian'] as bool;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: _saveFilter,
            icon: const Icon(Icons.save_rounded),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose filters to apply',
              style: TextStyle(fontSize: 22),
            ),
            Expanded(
              child: Column(
                children: [
                  buildSwitchListTile(
                    _isGluten,
                    'Gluten Free',
                    (newValue) {
                      setState(() {
                        _isGluten = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    _isLactose,
                    'Lactose Free',
                    (newValue) {
                      setState(() {
                        _isLactose = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    _isVegan,
                    'Vegan',
                    (newValue) {
                      setState(() {
                        _isVegan = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    _isVegetarian,
                    'Vegetarian',
                    (newValue) {
                      setState(() {
                        _isVegetarian = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
