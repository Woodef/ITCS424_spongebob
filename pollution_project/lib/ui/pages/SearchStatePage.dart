import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pollution_project/ui/pages/SearchCityPage.dart';
import 'package:pollution_project/ui/widgets/MyNavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchStatePage extends StatefulWidget {
  String country;
  SearchStatePage({Key? key, required this.country}) : super(key: key);

  @override
  _SearchStatePageState createState() => _SearchStatePageState();
}

class _SearchStatePageState extends State<SearchStatePage> {
  List<dynamic> _stateList = List.empty(growable: true);
  List<dynamic> _foundStates = List.empty(growable: true);

  Future<void> _getState() async {
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/states?country=${widget.country}&key=${dotenv.env['apiKey']}'));
    if (response.statusCode == 200) {
      var states = json.decode(response.body);
      print(states);
      setState(() {
        _stateList = states['data'];
        _foundStates = _stateList;
        print(_stateList);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    _getState();
  }

  void _runFilter(String enteredKeyword) {
    List<dynamic> results = List.empty(growable: true);
    if (enteredKeyword.isEmpty) {
      results = _stateList;
    } else {
      results = _stateList
          .where((state) => state['state']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _stateList = results;
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
                  labelText: 'Search state', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _foundStates.length,
                itemBuilder: ((context, index) => Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(_foundStates[index]['state']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchCityPage(
                                country: widget.country,
                                state: _foundStates[index]['state'],
                              ),
                            ),
                          );
                        },
                      ),
                    )),
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
