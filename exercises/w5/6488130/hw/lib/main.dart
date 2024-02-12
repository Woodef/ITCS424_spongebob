import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hw/models/place.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => PlaceModel(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', initialRoute: '/rank', routes: {
      '/rank': (context) => const MyRankPage(),
      '/placeDetail': (context) => const MyPlace()
    });
  }
}

// Ranking page
class MyRankPage extends StatelessWidget {
  const MyRankPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(
          name: "Ranking",
        ),
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

// App top bar
class MyAppBar extends StatelessWidget {
  final String name;

  MyAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.search),
          Text("Air Pollution"),
          Icon(Icons.notifications_none_outlined)
        ],
      ),
      Text(this.name, style: TextStyle(fontSize: 15))
    ]);
  }
}

// App bottom navigation bar
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

// Header of the list of place in Rank page
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

// A box for each place in Rank page
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
        child: ElevatedButton(
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
              ]),
          onPressed: () {
            var place = context.read<PlaceModel>();
            place.setPlaceName(this.name);
            place.setAqi(this.aqi, this.bgColor, this.txtColor);
            Navigator.pushNamed(context, '/placeDetail');
          },
        ));
  }
}

class MyPlace extends StatelessWidget {
  const MyPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(name: "Place"),
        backgroundColor: Colors.white,
      ),
      body: Consumer<PlaceModel>(builder: (context, place, child) {
        return Container(
          child: ListView(
            children: <Widget>[
              MyPlaceDetail(
                  placeName: place.placeName,
                  aqi: place.aqi,
                  desc: place.desc,
                  bgColor: place.bgColor),
              Container(
                padding: EdgeInsets.all(15),
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text('12:00'),
                          Text(
                            "${place.minAqi} - ${place.maxAqi}",
                            style: TextStyle(
                                backgroundColor: place.bgColor,
                                color: place.txtColor),
                          ),
                          const Text('30°')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text('13:00'),
                          Text(
                            "${place.minAqi} - ${place.maxAqi}",
                            style: TextStyle(
                                backgroundColor: place.bgColor,
                                color: place.txtColor),
                          ),
                          const Text('30°')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text('14:00'),
                          Text(
                            "${place.minAqi} - ${place.maxAqi}",
                            style: TextStyle(
                                backgroundColor: place.bgColor,
                                color: place.txtColor),
                          ),
                          const Text('30°')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text('15:00'),
                          Text(
                            "${place.minAqi} - ${place.maxAqi}",
                            style: TextStyle(
                                backgroundColor: place.bgColor,
                                color: place.txtColor),
                          ),
                          const Text('30°')
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text('16:00'),
                          Text(
                            "${place.minAqi} - ${place.maxAqi}",
                            style: TextStyle(
                                backgroundColor: place.bgColor,
                                color: place.txtColor),
                          ),
                          const Text('30°')
                        ],
                      )
                    ]),
              ),
              Divider(color: Colors.black),
              Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Wed', style: TextStyle(fontSize: 20)),
                          Image(
                            image: ResizeImage(
                                AssetImage("assets/images/sunny.png"),
                                width: 40),
                          ),
                          Text('35° - 40°', style: TextStyle(fontSize: 20))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      Row(
                        children: <Widget>[
                          Text('Thu', style: TextStyle(fontSize: 20)),
                          Image(
                            image: ResizeImage(
                                AssetImage("assets/images/thunderstorm.png"),
                                width: 40),
                          ),
                          Text('29° - 33°', style: TextStyle(fontSize: 20))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      Row(
                        children: <Widget>[
                          Text('Fri', style: TextStyle(fontSize: 20)),
                          Image(
                            image: ResizeImage(
                                AssetImage("assets/images/cloudy.png"),
                                width: 40),
                          ),
                          Text('32° - 36°', style: TextStyle(fontSize: 20))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      Row(
                        children: <Widget>[
                          Text('Sat', style: TextStyle(fontSize: 20)),
                          Image(
                            image: ResizeImage(
                                AssetImage("assets/images/sunny.png"),
                                width: 40),
                          ),
                          Text('35° - 40°', style: TextStyle(fontSize: 20))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      ),
                      Row(
                        children: <Widget>[
                          Text('Sun', style: TextStyle(fontSize: 20)),
                          Image(
                            image: ResizeImage(
                                AssetImage("assets/images/cloudy.png"),
                                width: 40),
                          ),
                          Text('32° - 36°', style: TextStyle(fontSize: 20))
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      )
                    ],
                  )),
            ],
          ),
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        );
      }),
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.grey[50],
    );
  }
}

class MyPlaceDetail extends StatelessWidget {
  final String placeName;
  final int aqi;
  final String desc;
  final Color bgColor;

  MyPlaceDetail(
      {Key? key,
      required this.placeName,
      required this.aqi,
      required this.desc,
      required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
          child: Text(this.placeName, style: TextStyle(fontSize: 30)),
        ),
        Text(
          this.aqi.toString(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text('US AQI', style: TextStyle(fontSize: 20)),
        Container(
          child: Text(
            this.desc,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
        )
      ]),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white, this.bgColor])),
      padding: EdgeInsets.all(50),
    );
  }
}
