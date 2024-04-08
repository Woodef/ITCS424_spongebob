import 'package:flutter/material.dart';

Color getBgColor(int aqius) {
  if (aqius >= 0 && aqius <= 50) {
    return const Color.fromRGBO(91, 226, 146, 1);
  } else if (aqius >= 51 && aqius <= 100) {
    return const Color.fromRGBO(252, 215, 74, 1);
  } else if (aqius >= 101 && aqius <= 150) {
    return const Color.fromRGBO(255, 153, 86, 1);
  } else if (aqius >= 151 && aqius <= 200) {
    return const Color.fromRGBO(255, 105, 96, 1);
  } else if (aqius >= 201 && aqius <= 300) {
    return const Color.fromRGBO(170, 124, 189, 1);
  } else if (aqius >= 301 && aqius <= 500) {
    return const Color.fromRGBO(168, 117, 134, 1);
  } else {
    return Colors.black;
  }
}

Color getTxtColor(int aqius) {
  if (aqius >= 0 && aqius <= 300) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

String getDescription(int aqius) {
  if (aqius >= 0 && aqius <= 50) {
    return 'Good';
  } else if (aqius >= 51 && aqius <= 100) {
    return 'Moderate';
  } else if (aqius >= 101 && aqius <= 150) {
    return 'Unhealthy for sensitive group';
  } else if (aqius >= 151 && aqius <= 200) {
    return 'Unhealthy';
  } else if (aqius >= 201 && aqius <= 300) {
    return 'Very unhealthy';
  } else if (aqius >= 301 && aqius <= 500) {
    return 'Hazardous';
  } else {
    return 'Error';
  }
}

String getImage(String ic) {
  String img = ic;
  String num = ic.substring(0, 2);

  if (num == '03') {
    img = '03d';
  } else if (num == '04') {
    img = '04d';
  } else if (num == '09') {
    img = '09d';
  } else if (num == '11') {
    img = '11d';
  } else if (num == '13') {
    img = '13d';
  } else if (num == '50') {
    img = '50d';
  } else {
    img = '03d';
  }

  return img;
}
