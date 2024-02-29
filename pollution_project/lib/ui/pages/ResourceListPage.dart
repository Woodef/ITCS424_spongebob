import 'package:flutter/material.dart';

class ResourceListPage extends StatefulWidget {
  ResourceListPage({Key? key}) : super(key: key);

  @override
  _ResourceListPageState createState() => _ResourceListPageState();
}

class _ResourceListPageState extends State<ResourceListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ResourceListPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('ResourceListPage')],
        ),
      ),
    );
  }
}
