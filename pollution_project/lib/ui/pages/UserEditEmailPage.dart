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
        title: Text('UserEditEmailPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('UserEditEmailPage')],
        ),
      ),
    );
  }
}
