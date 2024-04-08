import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserModel extends ChangeNotifier {
  String _email = '';
  String _fullname = '';
  List<Map<String, dynamic>> _savedPlaces = [];
  String _stateName = '';
  String _countryName = '';
  String _cityName = '';
  int _aqius = 0;
  int _tp = 0;
  int _hu = 0;
  String _ic = '';

  FirebaseFirestore db = FirebaseFirestore.instance;

  String get email => _email;
  String get fullname => _fullname;
  List<Map<String, dynamic>> get savePlaces => _savedPlaces;
  int get lengthPlace => _savedPlaces.length;
  String get state => _stateName;
  String get country => _countryName;
  String get city => _cityName;
  int get aqius => _aqius;
  int get tp => _tp;
  int get hu => _hu;
  String get ic => _ic;

  void setState(String state) {
    _stateName = state;
    notifyListeners();
  }

  void setCountry(String country) {
    _countryName = country;
    notifyListeners();
  }

  void setCity(String city) {
    _cityName = city;
    notifyListeners();
  }

  void setAqius(int aqius) {
    _aqius = aqius;
    notifyListeners();
  }

  void setTp(int tp) {
    _tp = tp;
    notifyListeners();
  }

  void setHu(int hu) {
    _hu = hu;
    notifyListeners();
  }

  void setIc(String ic) {
    _ic = ic;
    notifyListeners();
  }

  Future<void> getCity(String country, String state, String city) async {
    sleep(const Duration(seconds: 1));
    final response = await http.get(Uri.parse(
        'http://api.airvisual.com/v2/city?city=$city&state=$state&country=$country&key=${dotenv.env['apiKey']}'));
    if (response.statusCode == 200) {
      var city = json.decode(response.body);
      print('user mode: getCity $city');
      _stateName = city['data']['state'];
      _countryName = city['data']['country'];
      _cityName = city['data']['city'];
      _aqius = city['data']['current']['pollution']['aqius'];
      _tp = city['data']['current']['weather']['tp'];
      _hu = city['data']['current']['weather']['hu'];
      _ic = city['data']['current']['weather']['ic'];
    } else {
      print(response.statusCode);
    }
    notifyListeners();
  }

  // Set places from firestore
  void setPlacesFromSavedPlaces() {
    db.collection('users').doc(_email).collection('saved_places').get().then(
        (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data();
        print('${docSnapshot.id} => $data');
        getCity(data['country'], data['state'], data['city']).then((value) {
          // final placeApp = <String, dynamic>{
          //   'order': data['order'],
          //   'country': _countryName,
          //   'state': _stateName,
          //   'city': _cityName,
          //   'aqius': _aqius,
          //   'tp': _tp,
          //   'hu': _hu,
          //   'ic': _ic,
          // };
          if (!placeExists(country, state, city)) {
            savePlaces.insert(data['order'], <String, dynamic>{
              'order': data['order'],
              'country': _countryName,
              'state': _stateName,
              'city': _cityName,
              'aqius': _aqius,
              'tp': _tp,
              'hu': _hu,
              'ic': _ic,
            });
          }
          print('setPlacesFromSavedPlaces: $savePlaces');
        });
      }
    }, onError: (e) => print('Error completing: $e'));
    notifyListeners();
  }

  // Add place to array and firestore
  void addToSavedPlaces() {
    // Check if place is in the list
    if (!placeExists(_countryName, _stateName, _cityName)) {
      final placeDB = <String, dynamic>{
        'order': lengthPlace == 0 ? 0 : lengthPlace,
        'country': _countryName,
        'state': _stateName,
        'city': _cityName
      };

      final placeApp = <String, dynamic>{
        'order': lengthPlace == 0 ? 0 : lengthPlace,
        'country': _countryName,
        'state': _stateName,
        'city': _cityName,
        'aqius': _aqius,
        'tp': _tp,
        'hu': _hu,
        'ic': _ic,
      };

      // Add place to array to the end of array
      _savedPlaces.add(placeApp);

      // Add place to firestore
      db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .doc('${_countryName}_${_stateName}_$_cityName')
          .set(placeDB)
          .onError((error, stackTrace) => "Error writing document: $error");
    }
    notifyListeners();
    // Else, don't add (but the program won't allow this anyway)
  }

  // Remove place from array and firestore
  void removeFromSavedPlaces(String country, String state, String city) {
    if (placeExists(country, state, city)) {
      // Remove place at some position
      _savedPlaces.removeWhere((item) =>
          item['country'] == country &&
          item['state'] == state &&
          item['city'] == city);

      // Remove place from firestore
      db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .doc('${country}_${state}_$city')
          .delete()
          .then((doc) => print('Document deleted'),
              onError: (e) => print("Error updating document $e"));
    }
    notifyListeners();
  }

  bool placeExists(String country, String state, String city) {
    for (var place in _savedPlaces) {
      if (country == place['country'] &&
          state == place['state'] &&
          city == place['city']) {
        return true;
      }
    }
    return false;
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setFullname() {
    db.collection('users').doc(_email).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        _fullname = data['full_name'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    notifyListeners();
  }
}
