import 'package:flutter/material.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';

class PlaceManagePage extends StatefulWidget {
  PlaceManagePage({Key? key}) : super(key: key);

  @override
  _PlaceManagePageState createState() => _PlaceManagePageState();
}

class _PlaceManagePageState extends State<PlaceManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlaceManagePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('PlaceManagePage')],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}
