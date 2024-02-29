import 'package:flutter/material.dart';

class UserEditPasswordPage extends StatefulWidget {
  UserEditPasswordPage({Key? key}) : super(key: key);

  @override
  _UserEditPasswordPageState createState() => _UserEditPasswordPageState();
}

class _UserEditPasswordPageState extends State<UserEditPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UserEditPasswordPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('UserEditPasswordPage')],
        ),
      ),
    );
  }
}
