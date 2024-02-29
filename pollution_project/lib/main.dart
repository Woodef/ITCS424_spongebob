import 'package:flutter/material.dart';
import 'package:pollution_project/ui/pages/PlaceListPage.dart';
import 'package:pollution_project/ui/pages/LoginPage.dart';
import 'package:pollution_project/ui/pages/RegisterPage.dart';
import 'package:pollution_project/ui/pages/UserPage.dart';
import 'package:pollution_project/ui/pages/UserEditEmailPage.dart';
import 'package:pollution_project/ui/pages/UserEditPasswordPage.dart';
import 'package:pollution_project/ui/pages/UserManagePage.dart';
import 'package:pollution_project/ui/pages/ResourcePage.dart';
import 'package:pollution_project/ui/pages/ResourceListPage.dart';
import 'package:pollution_project/ui/pages/SearchPage.dart';
import 'package:pollution_project/ui/pages/PlaceManagePage.dart';
import 'package:pollution_project/ui/pages/PlacePage.dart';
import 'package:provider/provider.dart';
import 'package:pollution_project/models/place.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => PlaceModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Air Pollution Project',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/placeList': (context) => PlaceListPage(),
          '/place': (context) => PlacePage(),
          '/placeManage': (context) => PlaceManagePage(),
          '/search': (context) => SearchPage(),
          '/resourceList': (context) => ResourceListPage(),
          '/resource': (context) => ResourcePage(),
          '/user': (context) => UserPage(),
          '/userManage': (context) => UserManagePage(),
          '/userEditEmailPage': (context) => UserEditEmailPage(),
          '/userEditPasswordPage': (context) => UserEditPasswordPage(),
        });
  }
}
