import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/models/user.dart';
import 'package:pollution_project/ui/pages/LoadingPage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pollution_project/ui/cityFunctions.dart';
import 'package:provider/provider.dart';

class PlacePage extends StatefulWidget {
  String country;
  String state;
  String city;

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
  bool _isLoading = true;

  Future<void> _getCity() async {
    var user = context.watch<UserModel>();
    Map<String, dynamic> place = user.savePlaces.firstWhere(
      (element) =>
          element['country'] == widget.country &&
          element['state'] == widget.state &&
          element['city'] == widget.city,
      orElse: () => {'country': 'empty'},
    );

    if (place['country'] == 'empty') {
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
          _isLoading = false;
        });
      } else {
        setState(() {
          _stateName = 'Unable to fetch data from API';
          _countryName = 'error: ${response.statusCode}';
          _cityName = 'error: ${response.statusCode}';
          _aqius = 0;
          _tp = 0;
          _hu = 0;
          _ic = 'error';
          _isLoading = false;
        });
        print(response.statusCode);
      }
    } else {
      setState(() {
        _stateName = place['state'];
        _countryName = place['country'];
        _cityName = place['city'];
        _aqius = place['aqius'];
        _tp = place['tp'];
        _hu = place['hu'];
        _ic = place['ic'];
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCity();
  }

  @override
  Widget build(BuildContext context) {
    print(_countryName);

    var user = context.watch<UserModel>();

    IconData icon;
    print('PlacePage: ${user.savePlaces}');
    print('PlacePage: ${user.lengthPlace}');
    print(user.placeExists(_countryName, _stateName, _cityName));

    if (user.placeExists(_countryName, _stateName, _cityName)) {
      icon = Icons.remove;
    } else {
      icon = Icons.add;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
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
      body: _isLoading
          ? const LoadingPage()
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.white, BlendMode.softLight),
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
      bottomNavigationBar: const MyNavigationBar(),
      floatingActionButton: FloatingActionButton.small(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          tooltip: 'Place Added',
          onPressed: () async {
            if (_ic == 'error') {
              print('Error onPressed tooltip');
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Place cannot be added due to error.'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'))
                  ],
                ),
              );
            } else {
              if (user.placeExists(_countryName, _stateName, _cityName)) {
                await user.removeFromSavedPlaces(
                    _countryName, _stateName, _cityName);
              } else {
                await user.addToSavedPlaces(
                    _countryName, _stateName, _cityName, _aqius, _tp, _hu, _ic);
              }
            }
          },
          child: Icon(icon,
              color: const Color.fromARGB(255, 0, 31, 96), size: 28)),
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
              fontSize: 40,
              height: 1.1,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            this.stateName,
            style: TextStyle(fontSize: 30, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            this.countryName,
            style: TextStyle(fontSize: 25, height: 1.1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Container(
            color: getBgColor(aqius),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            margin: EdgeInsets.all(10),
            child: Text(
              this.aqius.toString(),
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  color: getTxtColor(aqius)),
            ),
          ),
          Text('US AQI',
              style: TextStyle(
                fontSize: 25,
              )),
          const SizedBox(height: 15),
          Text(
            getDescription(aqius),
            textAlign: TextAlign.center,
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
