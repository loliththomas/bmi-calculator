import 'package:flutter/material.dart';

Color getBmiColor(double bmi) {
  if (bmi < 18.5) {
    return Colors.yellow;
  } else if (bmi <= 25) {
    return Colors.green;
  } else if (bmi <= 30) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
