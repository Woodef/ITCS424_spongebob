import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context) {
    var routes = ['/placeList', '/search', '/resourceList', '/user'];

    return NavigationBar(
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.location_on),
          icon: Icon(Icons.location_on_outlined),
          label: 'Places',
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.text_snippet),
          icon: Icon(Icons.text_snippet_outlined),
          label: 'Resources',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle_outlined),
          label: 'User',
        ),
      ],
      selectedIndex: index,
      onDestinationSelected: (int index) {
        Navigator.pushNamed(context, routes[index]);
      },
    );
  }
}
