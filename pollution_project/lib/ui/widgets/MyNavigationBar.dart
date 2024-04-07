import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  int index;
  MyNavigationBar({Key? key, this.index = 0}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
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
      selectedIndex: widget.index,
      onDestinationSelected: (int index) {
        setState(() {
          // pass index as parameter
          widget.index = index;
          Navigator.pushNamed(context, routes[widget.index]);
        });
      },
    );
  }
}
