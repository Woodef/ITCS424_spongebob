import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String _email = '';
  String _fullname = '';
  List<Map<String, dynamic>> _savedPlaces = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  String get email => _email;
  String get fullname => _fullname;
  List<Map<String, dynamic>> get savePlaces => _savedPlaces;
  int get lengthPlace => _savedPlaces.length;

  // Get places from firestore
  void getPlacesFromSavedPlaces() {
    db.collection('users').doc(_email).collection('saved_places').get().then(
        (querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        _savedPlaces.insert(docSnapshot.data()['order'],
            docSnapshot.data() as Map<String, dynamic>);
      }
    }, onError: (e) => print('Error completing: $e'));
    notifyListeners();
  }

  // Add place to array and firestore
  void addToSavedPlaces(String country, String state, String city) {
    // Check if place is in the list
    if (!placeExists(country, state, city)) {
      final place = <String, dynamic>{
        'order': lengthPlace == 0 ? 0 : lengthPlace,
        'country': country,
        'state': state,
        'city': city
      };

      // Add place to array to the end of array
      _savedPlaces.add(place);

      // Add place to firestore
      db
          .collection('users')
          .doc(_email)
          .collection('saved_places')
          .doc('${country}_${state}_$city')
          .set(place)
          .onError((error, stackTrace) => "Error writing document: $error");
    }
    notifyListeners();
    // Else, don't add (but the program won't allow this anyway)
  }

  // Remove place from array and firestore
  void removeFromSavedPlaces(
      String country, String state, String city, int order) {
    if (placeExists(country, state, city)) {
      // Remove place at some position
      _savedPlaces.removeAt(order);

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
