import 'package:flutter/material.dart';

class UserEditPasswordPage extends StatefulWidget {
  UserEditPasswordPage({Key? key}) : super(key: key);

  @override
  _UserEditPasswordPageState createState() => _UserEditPasswordPageState();
}

class _UserEditPasswordPageState extends State<UserEditPasswordPage> {
  String _oldPassword = '';
  String _newPassword = '';
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Old Password',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _oldPassword = value;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your old password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'New Password',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  _newPassword = value;
                });
              },
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: 'Enter your new password',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle password change logic here
              },
              child: Text('Confirm Password'),
            ),
          ],
        ),
      ),
    );
  }
}
