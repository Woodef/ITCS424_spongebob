import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class LoadData {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> _fetchData() async {
    String apiKey = 'a48baa46-d7fc-4b2b-9a1f-531acb01c546';

    // Get countries
    final response = await http
        .get(Uri.parse('http://api.airvisual.com/v2/countries?key=$apiKey'));
    if (response.statusCode == 200) {
      final countries = json.decode(response.body);
      print(countries);

      // Get states in each country
      for (int i = 0; i < countries['data'].length; i++) {
        final response = await http.get(Uri.parse(
            'http://api.airvisual.com/v2/states?country=${countries['data'][i]['country']}&key=$apiKey'));
        if (response.statusCode == 200) {
          final states = json.decode(response.body);
          print(states);

          // Get cities in each state of a particular country
          for (int j = 0; j < states['data'].length; j++) {
            final response = await http.get(Uri.parse(
                'http://api.airvisual.com/v2/cities?state=${states['data'][j]['state']}&country=${countries['data'][i]['country']}&key=$apiKey'));
            if (response.statusCode == 200) {
              final cities = json.decode(response.body);
              print(cities);

              // Store country, state, city in the db
              for (int k = 0; k < cities.length; k++) {
                final place = <String, String>{
                  'country': countries['data'][i]['country'],
                  'state': states['data'][j]['state'],
                  'city': cities['data'][k]['city'],
                };
              }
            }
          }
        }
      }
    }
  }
}
