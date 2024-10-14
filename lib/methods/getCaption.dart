import 'package:flutter/material.dart';

String getCaption(double bmi) {
  if (bmi < 18.5) {
    return "You need more nutrients!";
  } else if (bmi >= 18.5 && bmi <= 25) {
    return "Great job! You\'re doing well :)";
  } else if (bmi > 25 && bmi <= 30) {
    return "Watch your diet !";
  } else {
    return "Time to change your lifestyle !!";
  }
}
