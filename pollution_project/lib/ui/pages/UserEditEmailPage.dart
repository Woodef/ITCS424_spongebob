import 'package:flutter/material.dart';

class UserEditEmailPage extends StatefulWidget {
  UserEditEmailPage({Key? key}) : super(key: key);

  @override
  _UserEditEmailPageState createState() => _UserEditEmailPageState();
}

class _UserEditEmailPageState extends State<UserEditEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Change Email',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'New Email',
                hintText: 'example@hotmail.com',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement email change functionality
              },
              child: Text('Confirm Email'),
            ),
          ],
        ),
      ),
    );
  }
}
