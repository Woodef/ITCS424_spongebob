import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/pages/PlacePage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchCityPage extends StatefulWidget {
  String country;
  String state;

  SearchCityPage({Key? key, required this.country, required this.state})
      : super(key: key);

  @override
  _SearchCityPageState createState() => _SearchCityPageState();
}

class _SearchCityPageState extends State<SearchCityPage> {
  List<dynamic> _cityList = [];
  List<dynamic> _foundCities = [];

  Future<void> _getCities() async {
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/cities?state=${widget.state}&country=${widget.country}&key=${dotenv.env['apiKey']}'));
    if (response.statusCode == 200) {
      var cities = json.decode(response.body);
      print(cities);
      setState(() {
        _cityList = cities['data'];
        _foundCities = cities['data'];
        print(_foundCities);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    _cityList.clear();
    _foundCities.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCities();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = List.empty(growable: true);
    if (enteredKeyword.isEmpty) {
      results = _cityList;
    } else {
      results = _cityList
          .where((city) =>
              city['city'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundCities = results;
    });
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
                'Search',
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search city', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundCities.length,
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(_foundCities[index]['city']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlacePage(
                              country: widget.country,
                              state: widget.state,
                              city: _foundCities[index]['city'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MyNavigationBar(
        index: 1,
      ),
      backgroundColor: Colors.white,
    );
  }
}
