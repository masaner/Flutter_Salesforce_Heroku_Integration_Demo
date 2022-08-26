import 'package:flutter/material.dart';

const temptextCold = TextStyle(
    fontSize: 75,
    color: Color.fromARGB(255, 68, 111, 229),
    fontWeight: FontWeight.bold);

const tempsubtextCold = TextStyle(
    fontSize: 35,
    color: Color.fromARGB(255, 68, 111, 229),
    fontStyle: FontStyle.italic);

const temptextHot = TextStyle(
    fontSize: 75,
    color: Color.fromARGB(255, 225, 65, 6),
    fontWeight: FontWeight.bold);

const tempsubtextHot = TextStyle(
    fontSize: 35,
    color: Color.fromARGB(255, 225, 65, 6),
    fontStyle: FontStyle.italic);

const citytext = TextStyle(
    fontSize: 35,
    color: Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.bold);

const infotext =
    TextStyle(fontSize: 22, color: Colors.white, fontStyle: FontStyle.italic);

Color colorTempToRGB(int colorTemp) {
  if (colorTemp < -20) {
    Color freezingPlus = Color.fromARGB(255, 4, 70, 175);
    return freezingPlus;
  }
  if (colorTemp >= -20 && colorTemp < 0) {
    Color freezing = Color.fromARGB(255, 53, 130, 255);
    return freezing;
  }
  if (colorTemp >= 0 && colorTemp < 8) {
    Color cold = Color.fromARGB(255, 108, 189, 255);
    return cold;
  }
  if (colorTemp >= 8 && colorTemp < 10) {
    Color chilly = Color.fromARGB(255, 50, 228, 255);
    return chilly;
  }
  if (colorTemp >= 10 && colorTemp < 20) {
    Color cool = Color.fromARGB(255, 205, 255, 255);
    return cool;
  }
  if (colorTemp >= 20 && colorTemp < 28) {
    Color warm = Color.fromARGB(255, 255, 195, 62);
    return warm;
  }
  if (colorTemp >= 28 && colorTemp < 35) {
    Color hot = Color.fromARGB(255, 227, 80, 0);
    return hot;
  }
  if (colorTemp >= 35) {
    Color burning = Color.fromARGB(255, 255, 0, 0);
    return burning;
  }
  return Color.fromARGB(255, 255, 255, 255);
}
