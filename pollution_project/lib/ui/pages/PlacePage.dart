import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/models/user.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pollution_project/ui/cityFunctions.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatefulWidget {
  String country = 'Thailand';
  String state = 'Bangkok';
  String city = 'Phasi Charoen';

  PlacePage({
    Key? key,
    required this.country,
    required this.state,
    required this.city,
  }) : super(key: key);

  @override
  _PlacePageState createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  String _cityName = '';
  String _stateName = '';
  String _countryName = '';
  int _aqius = 0;
  int _tp = 0;
  int _hu = 0;
  String _ic = '';

  Future<void> _getCity() async {
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/city?city=${widget.city}&state=${widget.state}&country=${widget.country}&key=${dotenv.env['apiKey']}'));
    if (response.statusCode == 200) {
      var city = json.decode(response.body);
      print(city);
      setState(() {
        _stateName = city['data']['state'];
        _countryName = city['data']['country'];
        _cityName = city['data']['city'];
        _aqius = city['data']['current']['pollution']['aqius'];
        _tp = city['data']['current']['weather']['tp'];
        _hu = city['data']['current']['weather']['hu'];
        _ic = city['data']['current']['weather']['ic'];
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCity();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserModel>();
    IconData icon;
    if (user.placeExists(_countryName, _stateName, _cityName)) {
      icon = Icons.remove;
    } else {
      icon = Icons.add;
    }

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
                style: TextStyle(fontSize: 15),
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
          child: Container(
            child: ListView(
              children: [
                MyCurrentDetail(
                  cityName: _cityName,
                  countryName: _countryName,
                  stateName: _stateName,
                  aqius: _aqius,
                  ic: _ic,
                  tp: _tp,
                  hu: _hu,
                )
              ],
            ),
          )),
      bottomNavigationBar: MyNavigationBar(),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          tooltip: 'Place Added',
          onPressed: () {
            if (user.placeExists(_countryName, _stateName, _cityName)) {
              user.removeFromSavedPlaces(_countryName, _stateName, _cityName,
                  user.lengthPlace == 0 ? 0 : user.lengthPlace - 1);
            } else {
              user.addToSavedPlaces(_countryName, _stateName, _cityName);
            }
          },
          // how to make this change automatically?
          child: Icon(icon, color: Color.fromARGB(255, 0, 31, 96), size: 28)),
    );
  }
}

class MyCurrentDetail extends StatelessWidget {
  final String countryName;
  final String stateName;
  final String cityName;
  final int aqius;
  final String ic;
  final int tp;
  final int hu;

  MyCurrentDetail({
    Key? key,
    required this.countryName,
    required this.stateName,
    required this.cityName,
    required this.aqius,
    required this.ic,
    required this.tp,
    required this.hu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Text(
            this.cityName,
            style: TextStyle(
              fontSize: 45,
              height: 1.1,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            this.stateName,
            style: TextStyle(fontSize: 35, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            this.countryName,
            style: TextStyle(fontSize: 25, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            this.aqius.toString(),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('US AQI',
              style: TextStyle(
                fontSize: 25,
              )),
          const SizedBox(height: 15),
          Text(
            getDescription(aqius),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Row(
                children: [
                  Image.network(
                    'https://www.airvisual.com/images/${getImage(this.ic)}.png',
                    height: 40,
                  ),
                  SizedBox(width: 5),
                  Text('${this.tp.toString()}°',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.water_drop_rounded),
                  Text('${this.hu}%', style: TextStyle(fontSize: 20)),
                ],
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
        ],
      ),
      padding: EdgeInsets.all(50),
    );
  }
}
