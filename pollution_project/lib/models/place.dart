import 'package:flutter/material.dart';

class PlaceModel extends ChangeNotifier {
  String _cityName = "";
  String _countryName = "";
  int _aqi = 0;
  int _tp = 0;
  String _desc = "Good";
  int _min_aqi = 0;
  int _max_aqi = 50;
  Color _bgColor = Colors.green;
  Color _txtColor = Colors.black;

  String get cityName => _cityName;
  String get countryName => _countryName;
  int get aqi => _aqi;
  String get desc => _desc;
  int get minAqi => _min_aqi;
  int get maxAqi => _max_aqi;
  int get tp => _tp;
  Color get bgColor => _bgColor;
  Color get txtColor => _txtColor;

  void setPlaceName(String cityName, String countryName) {
    _cityName = cityName;
    _countryName = countryName;
    notifyListeners();
  }

  void setTp(int tp) {
    _tp = tp;
    notifyListeners();
  }

  void setAqi(int aqi) {
    _aqi = aqi;
    _bgColor = bgColor;
    _txtColor = txtColor;
    if (_aqi >= 51 && _aqi <= 100) {
      _min_aqi = 51;
      _max_aqi = 100;
      _desc = "Moderate";
    } else if (_aqi >= 101 && _aqi <= 150) {
      _min_aqi = 101;
      _max_aqi = 150;
      _desc = "Unhealthy for sensitive groups";
    } else if (_aqi >= 151 && _aqi <= 200) {
      _min_aqi = 151;
      _max_aqi = 200;
      _desc = "Unhealthy";
    } else if (_aqi >= 201) {
      _min_aqi = 201;
      if (_aqi > 300) {
        _max_aqi = _aqi;
      } else {
        _max_aqi = 300;
      }
      _desc = "Very unhealthy";
    }

    notifyListeners();
  }
}
