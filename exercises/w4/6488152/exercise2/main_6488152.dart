import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //set structure of our app
      title: '6488152',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Air pllution'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("6488152 Resources")),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          ProductBox(
            name: "1",
            description: "How wind and weather affect air pollution",
            image: "map.png",
          ),
          ProductBox(
            name: "2",
            description: "Air quality reports explained",
            image: "playiphone.jpg",
          ),
          ProductBox(
            name: "3",
            description: "What is the air quality index (AQI)?",
            image: "iphone3.jpg",
          ),
          ProductBox(
            name: "4",
            description: "What pollutants should I watch out for?",
            image: "mask.jpg",
          ),
          ProductBox(
            name: "5",
            description: "The real cost of air pollution",
            image: "weather.png",
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.name, required this.description, required this.image}) : super(key: key);
  final String name;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset("assets/appimages/" + image),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(this.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(this.description),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
