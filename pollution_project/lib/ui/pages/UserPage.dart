import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pollution_project/ui/pages/LoginPage.dart';
import 'package:pollution_project/ui/pages/PlaceListPage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/user_placeholder.png'),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              'Name: John',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Surname: Doe',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 40),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Manage Account'),
              onTap: () {
                // Implement Manage Account functionality
                Navigator.pushNamed(context, '/userManage');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
              onTap: () {
                // Implement log out functionality
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/main');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(index: 3),
    );
  }
}

