import 'package:flutter/material.dart';
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
        // Grey background color
        title: Text('General'), // Title "General"
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildOptionButton(context, 'Change Email'),
          _buildOptionButton(context, 'Change Password'),
        ],
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
        if (text == 'Change Email') {
          // Navigate to change email page
          Navigator.pushNamed(context, '/userEditEmailPage');
        } else if (text == 'Change Password') {
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
