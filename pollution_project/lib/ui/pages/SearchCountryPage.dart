import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/pages/SearchStatePage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchCountryPage extends StatefulWidget {
  SearchCountryPage({Key? key}) : super(key: key);

  @override
  _SearchCountryPageState createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  List<dynamic> _countryList = [];
  List<dynamic> _foundCountries = [];

  Future<void> _getCountry() async {
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/countries?key=${dotenv.env['apiKey']}'));
    if (response.statusCode == 200) {
      var countries = json.decode(response.body);
      print(countries);
      setState(() {
        _countryList = countries['data'];
        _foundCountries = countries['data'];
        print(_foundCountries);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void dispose() {
    _countryList.clear();
    _foundCountries.clear();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCountry();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = List.empty(growable: true);
    if (enteredKeyword.isEmpty) {
      results = _countryList;
    } else {
      results = _countryList
          .where((country) => country['country']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundCountries = results;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Search',
              style: TextStyle(fontSize: 15),
            )
          ],
        ),
        automaticallyImplyLeading: false,
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
                  labelText: 'Search country', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundCountries.length,
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(_foundCountries[index]['country']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchStatePage(
                                country: _foundCountries[index]['country']),
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
