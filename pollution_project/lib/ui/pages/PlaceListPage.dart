import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pollution_project/models/place.dart';

class PlaceListPage extends StatefulWidget {
  PlaceListPage({Key? key}) : super(key: key);

  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  String _cityName = 'Loading...';
  String _countryName = 'Loading...';
  int _tp = 0;
  int _aqi = 0;

  Future<void> _fetchData() async {
    String apiKey = 'a48baa46-d7fc-4b2b-9a1f-531acb01c546';
    final response = await http
        .get(Uri.parse('http://api.airvisual.com/v2/nearest_city?key=$apiKey'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        _cityName = body['data']['city'];
        _countryName = body['data']['country'];
        _tp = body['data']['current']['weather']['tp'];
        _aqi = body['data']['current']['pollution']['aqius'];
      });
    } else {
      setState(() {
        _cityName = 'Failed to fetch data';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

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
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text('$_cityName, $_countryName'), Text('$_aqi US AQI')],
          ),
          onPressed: () {
            var place = context.read<PlaceModel>();
            place.setAqi(_aqi);
            place.setPlaceName(_cityName, _countryName);
            place.setTp(_tp);
            _fetchData();
            Navigator.pushNamed(context, '/place');
          },
        ),
      ),
      bottomNavigationBar: MyNavigationBar(),
      backgroundColor: Colors.purple[100],
    );
  }
}

// class PlaceBox extends StatelessWidget {
//   final String name;
//   final int aqi;

//   PlaceBox({
//     Key? key,
//     required this.name,
//     required this.aqi,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ();
//   }
// }
