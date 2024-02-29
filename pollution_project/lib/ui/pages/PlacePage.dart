import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:pollution_project/models/place.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatefulWidget {
  PlacePage({Key? key}) : super(key: key);

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              Text(
                'Air Pollution',
                style: GoogleFonts.birthstone(
                  textStyle: const TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              Text(
                'Place',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
          ),
        ),
        child: Consumer<PlaceModel>(
          builder: (context, place, child) {
            return Container(
              child: ListView(
                children: [
                  MyPlaceDetail(
                      placeName: place.cityName,
                      aqi: place.aqi,
                      desc: place.desc),
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
                                    AssetImage(
                                        "assets/images/thunderstorm.png"),
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
            );
          },
        ),
      ),
      bottomNavigationBar: MyNavigationBar(),
    );
  }
}

class MyPlaceDetail extends StatelessWidget {
  final String placeName;
  final int aqi;
  final String desc;

  MyPlaceDetail(
      {Key? key,
      required this.placeName,
      required this.aqi,
      required this.desc})
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
      padding: EdgeInsets.all(50),
    );
  }
}
