import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pollution_project/ui/pages/PlacePage.dart';
import 'package:pollution_project/ui/cityFunctions.dart';
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
  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserModel>();
    List<Map<String, dynamic>> placeList = user.savePlaces; // for loop

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
            const Text(
              'Place',
              style: TextStyle(fontSize: 15),
            )
          ],
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
              itemCount: user.lengthPlace,
              itemBuilder: ((context, index) {
                print('PlaceList: ${user.lengthPlace}');
                var place = placeList[index];
                return BoxItem(
                    city: place['city'],
                    state: place['state'],
                    country: place['country'],
                    ic: place['ic'],
                    tp: place['tp'],
                    aqius: place['aqius']);
              }),
            )),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

class BoxItem extends StatelessWidget {
  final String city;
  final String state;
  final String country;
  final String ic;
  final int tp;
  final int aqius;

  BoxItem({
    Key? key,
    required this.city,
    required this.state,
    required this.country,
    required this.ic,
    required this.tp,
    required this.aqius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlacePage(country: country, state: state, city: city),
          ),
        );
      },
      child: Container(
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
                    Text(
                      '$city, $state',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('$country', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.network(
                      'https://www.airvisual.com/images/${getImage(ic)}.png',
                      height: 20,
                    ),
                    SizedBox(width: 5),
                    Text('${tp.toString()}°'),
                  ],
                ),
              ],
            ),
            VerticalDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 5),
                    Text(
                      getDescription(aqius),
                      style: TextStyle(fontWeight: FontWeight.w500),
                      softWrap: true,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(1.5),
                  width: 30,
                  color: getBgColor(aqius),
                  child: Center(
                    child: Text(
                      aqius.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: getTxtColor(aqius),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Text('US AQI', style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
