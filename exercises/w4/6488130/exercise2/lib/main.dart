import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: <Widget>[
        MyHeader(),
        PlaceBox(
          rank: 1,
          name: 'New Delhi, India',
          aqi: 340,
          bgColor: Colors.deepPurple,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 2,
          name: 'Gokarna, India',
          aqi: 240,
          bgColor: Colors.purple,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 3,
          name: 'Ghaka, Bangladesh',
          aqi: 210,
          bgColor: Colors.red,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 4,
          name: 'Sarajevo, Bosnian',
          aqi: 210,
          bgColor: Colors.red,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 5,
          name: 'Lahore, Pakistan',
          aqi: 173,
          bgColor: Colors.red,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 6,
          name: 'Mumbai, India',
          aqi: 169,
          bgColor: Colors.red,
          txtColor: Colors.white,
        ),
        PlaceBox(
          rank: 7,
          name: 'Yangon, Myanmar',
          aqi: 153,
          bgColor: Colors.red,
          txtColor: Colors.white,
        ),
        PlaceBox(
            rank: 8,
            name: 'Kuala Lumpar, Malaysia',
            aqi: 124,
            bgColor: Colors.orange),
        PlaceBox(
            rank: 9,
            name: 'Bangkok, Thailand',
            aqi: 110,
            bgColor: Colors.orange),
        PlaceBox(
            rank: 10,
            name: 'Dubai, United Arab Emirates',
            aqi: 95,
            bgColor: Colors.yellow),
        PlaceBox(
            rank: 11,
            name: 'Budapest, Hungary',
            aqi: 94,
            bgColor: Colors.yellow),
        PlaceBox(
            rank: 12,
            name: 'Pristina, Kosovo',
            aqi: 90,
            bgColor: Colors.yellow),
      ]),
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.indigo[50],
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.search),
          Text("Air Pollution"),
          Icon(Icons.notifications)
        ],
      ),
      Text("Ranking", style: TextStyle(fontSize: 15))
    ]);
  }
}

class MyNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: <Widget>[
        NavigationDestination(
            icon: Icon(Icons.place_outlined), label: 'Places'),
        NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Map'),
        NavigationDestination(
            icon: Icon(Icons.score_outlined), label: 'Ranking'),
        NavigationDestination(
            icon: Icon(Icons.text_snippet_outlined), label: 'Resources'),
        NavigationDestination(
            icon: Icon(Icons.account_circle_outlined), label: 'User')
      ],
      backgroundColor: Colors.white,
    );
  }
}

class MyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 60,
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(""), Text("City, Country"), Text("AQI")]));
  }
}

class PlaceBox extends StatelessWidget {
  final int rank;
  final String name;
  final int aqi;
  final Color bgColor;
  final Color txtColor;

  PlaceBox(
      {Key? key,
      required this.rank,
      required this.name,
      required this.aqi,
      required this.bgColor,
      this.txtColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 40,
        margin: EdgeInsets.only(left: 40, right: 40),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(this.rank.toString()),
              Text(
                name,
              ),
              Text(
                this.aqi.toString(),
                style: TextStyle(
                    backgroundColor: this.bgColor, color: this.txtColor),
              ),
            ]));
  }
}
