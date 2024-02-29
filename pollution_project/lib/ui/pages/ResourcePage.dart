import 'package:flutter/material.dart';

class ResourcePage extends StatefulWidget {
  ResourcePage({Key? key}) : super(key: key);

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ResourcePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('ResourcePage')],
        ),
      ),
    );
  }
}
