import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pollution_project/models/user.dart';

class PlaceListPage extends StatefulWidget {
  PlaceListPage({Key? key}) : super(key: key);

  @override
  _PlaceListPageState createState() => _PlaceListPageState();
}

class _PlaceListPageState extends State<PlaceListPage> {
  String _cityName = '';
  String _stateName = '';
  String _countryName = '';
  int _aqius = 0;
  int _tp = 0;
  String _ic = '';

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserModel>();
    List<Map<String, dynamic>> placeList = user.savePlaces;
    // Future<void> getPlaces(String country, String state, String city) async {
    //   final response = await http.get(Uri.parse(
    //       'http://api.airvisual.com/v2/city?city=$city&state=$state&country=$country&key=${dotenv.env['apiKey']}'));
    //   if (response.statusCode == 200) {
    //     var city = json.decode(response.body);
    //     print(city);
    //     setState(() {
    //       _stateName = city['data']['state'];
    //       _countryName = city['data']['country'];
    //       _cityName = city['data']['city'];
    //       _aqius = city['data']['current']['pollution']['aqius'];
    //       _tp = city['data']['current']['weather']['tp'];
    //       _ic = city['data']['current']['weather']['ic'];
    //     });
    //   } else {
    //     print(response.statusCode);
    //   }
    // }

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
              const Text(
                'Place',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                print(user.lengthPlace);
                return _BoxItem();
              }),
            )),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

Widget _BoxItem() {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.wb_sunny),
                SizedBox(width: 5),
                Text('Place Name'),
              ],
            ),
            SizedBox(height: 10),
            Text('Location'),
            SizedBox(height: 10),
            Text('Dust: High'),
          ],
        ),
        VerticalDivider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.cloud),
                SizedBox(width: 5),
                Text('Weather'),
              ],
            ),
            SizedBox(height: 10),
            Text('Temperature: 25°C'),
          ],
        ),
      ],
    ),
  );
}
