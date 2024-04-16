import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class UserManagePage extends StatefulWidget {
  UserManagePage({Key? key}) : super(key: key);

  @override
  _UserManagePageState createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            _buildOptionButton(context, 'Change Password'),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(index: 3),
    );
  }
}

Widget _buildOptionButton(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: ElevatedButton(
      onPressed: () {
        // Handle button press, e.g., navigate to corresponding page
        if (text == 'Change Password') {
          // Navigate to change password page
          Navigator.pushNamed(context, '/userEditPasswordPage');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // White background color
        padding: EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}
