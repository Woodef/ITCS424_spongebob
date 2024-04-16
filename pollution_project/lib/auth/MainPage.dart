import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pollution_project/models/user.dart';
import 'package:pollution_project/ui/pages/PlaceListPage.dart';
import 'package:pollution_project/ui/pages/LoginPage.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            var user = context.read<UserModel>();
            user.reset();
            user.setEmail(snapshot.data!.email!);
            user.setFullname();
            user.setPlacesFromSavedPlaces();
            return PlaceListPage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
