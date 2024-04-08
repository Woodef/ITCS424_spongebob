import 'package:flutter/material.dart';
import 'package:pollution_project/ui/pages/PlaceListPage.dart';
import 'package:pollution_project/ui/pages/LoginPage.dart';
import 'package:pollution_project/ui/pages/RegisterPage.dart';
import 'package:pollution_project/ui/pages/UserPage.dart';
import 'package:pollution_project/ui/pages/UserEditPasswordPage.dart';
import 'package:pollution_project/ui/pages/UserManagePage.dart';
import 'package:pollution_project/ui/pages/ResourceListPage.dart';
import 'package:pollution_project/ui/pages/SearchCountryPage.dart';
import 'package:pollution_project/auth/MainPage.dart';
import 'package:provider/provider.dart';
import 'package:pollution_project/models/user.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
      create: (context) => UserModel(), child: const MyApp()));
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
          '/': (context) => const MainPage(),
          '/main': (context) => const MainPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/placeList': (context) => PlaceListPage(),
          '/search': (context) => SearchCountryPage(),
          '/resourceList': (context) => ResourceListPage(),
          '/user': (context) => UserPage(),
          '/userManage': (context) => UserManagePage(),
          '/userEditPasswordPage': (context) => UserEditPasswordPage(),
        });
  }
}
