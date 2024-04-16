import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/models/user.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Air Pollution',
              style: GoogleFonts.birthstone(
                textStyle: const TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            Text(
              'User Account',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/user-icon.png'),
                radius: 50,
              ),
              SizedBox(height: 20),
              Text(
                'Name: ${user.fullname}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 40),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Manage Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    // Implement Manage Account functionality
                    Navigator.pushNamed(context, '/userManage');
                  },
                ),
              ),
              SizedBox(height: 5),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Log-out',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () async {
                    var user = context.read<UserModel>();
                    // Implement log out functionality
                    FirebaseAuth.instance.signOut();
                    user.reset();
                    Navigator.pushNamed(context, '/main');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyNavigationBar(index: 3),
    );
  }
}
