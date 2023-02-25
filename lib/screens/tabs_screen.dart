import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<String> favourites;
  const TabsScreen({super.key, required this.favourites});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // final List<String> favourites;
  // _TabsScreenState({required this.favourites});
  List<Map<String, Object>> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': const Categories(), 'title': 'Category'},
      {
        'page': FavouritesScreen(favourites: widget.favourites),
        'title': 'Your Favourite'
      },
    ];

    print(widget.favourites);
  }

  int _selectPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectPageIndex]['title'] as String,
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.white,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
        ],
      ),
    );
  }
}
