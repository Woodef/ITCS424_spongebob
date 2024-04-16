import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserModel extends ChangeNotifier {
  // Variable declaration
  String _email = '';
  String _fullname = '';
  int placeLength = 0;
  List<Map<String, dynamic>> _savedPlaces = [];

  String _stateName = '';
  String _countryName = '';
  String _cityName = '';
  int _aqius = 0;
  int _tp = 0;
  int _hu = 0;
  String _ic = '';

  // Getter
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

  // Database
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Set Email
  Future<void> setEmail(String email) async {
    _email = email;
    notifyListeners();
  }

  // Set full name
  Future<void> setFullname() async {
    db.collection('users').doc(_email).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        _fullname = data['full_name'];
      },
      onError: (e) => print("Error getting document: $e"),
    );
    notifyListeners();
  }

  // Set places from firestore
  Future<void> setPlacesFromSavedPlaces() async {
    try {
      // Fetch documents from Firestore
      QuerySnapshot querySnapshot = await db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .orderBy('order') // must fetch in order
          .get();

      // Process each document in the query snapshot
      for (var docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        print('${docSnapshot.id} => $data');

        // Perform asynchronous operation to get city details
        await getCity(data['country'], data['state'], data['city']);
        print('$country $state $city');
        print(placeExists(country, state, city));
        print(savePlaces);
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
      }
    } catch (e) {
      print('Error in setPlacesFromSavedPlaces: $e');
    }
    notifyListeners();
  }

  // Get each city and set city variable in user model
  Future<void> getCity(String country, String state, String city) async {
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
      _stateName = 'ERROR';
      _countryName = 'ERROR';
      _cityName = 'ERROR';
      _aqius = response.statusCode;
      _tp = response.statusCode;
      _hu = response.statusCode;
      _ic = 'error';
      print(response.statusCode);
    }
  }

  // Add place to array and firestore
  Future<void> addToSavedPlaces(String countryName, String stateName,
      String cityName, int aqius, int tp, int hu, String ic) async {
    // Check if place is in the list
    if (!placeExists(countryName, stateName, cityName)) {
      final placeDB = <String, dynamic>{
        'order': lengthPlace,
        'country': countryName,
        'state': stateName,
        'city': cityName
      };

      final placeApp = <String, dynamic>{
        'order': lengthPlace,
        'country': countryName,
        'state': stateName,
        'city': cityName,
        'aqius': aqius,
        'tp': tp,
        'hu': hu,
        'ic': ic,
      };

      // Add place to array to the end of array
      _savedPlaces.add(placeApp);

      // Add place to firestore
      await db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .doc('${countryName}_${stateName}_$cityName')
          .set(placeDB)
          .onError((error, stackTrace) => "Error writing document: $error");
    }
    notifyListeners();
    // Else, don't add (but the program won't allow this anyway)
  }

  // Remove place from array and firestore
  Future<void> removeFromSavedPlaces(
      String country, String state, String city) async {
    if (placeExists(country, state, city)) {
      // Find the order of removed place
      int order = _savedPlaces.firstWhere((element) =>
          element['country'] == country &&
          element['state'] == state &&
          element['city'] == city)['order'];

      // Remove place at some position
      print('order: $order');
      _savedPlaces.removeWhere((item) => item['order'] == order);

      // Remove place from firestore
      await db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .doc('${country}_${state}_$city')
          .delete()
          .then((doc) => print('Document deleted'),
              onError: (e) => print("Error updating document $e"));

      // Update order of place
      for (int i = order; i < lengthPlace; i++) {
        _savedPlaces[i]['order'] = i;
        String country = _savedPlaces[i]['country'];
        String state = _savedPlaces[i]['state'];
        String city = _savedPlaces[i]['city'];
        await db
            .collection('users')
            .doc(_email)
            .collection('saved_places')
            .doc('${country}_${state}_$city')
            .update({'order': i}).then(
                (value) => print("Order updated successfully"),
                onError: (e) => print('Error updating order'));
      }
    }
    notifyListeners();
  }

  // Setter
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

  Future<void> setPlace(String country, String state, String city, int aqius,
      int tp, int hu, String ic) async {
    _stateName = state;
    _countryName = country;
    _cityName = city;
    _aqius = aqius;
    _tp = tp;
    _hu = hu;
    _ic = ic;
    notifyListeners();
  }

  // Reset information
  Future<void> reset() async {
    _email = '';
    _fullname = '';
    _savedPlaces = [];
    placeLength = 0;
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
}
