// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:student_management/style/style.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key, this.weatherData}) : super(key: key);

  final weatherData;
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late String city;
  late int temp;
  @override
  void initState() {
    infoToUI(widget.weatherData);
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
  }

  void infoToUI(dynamic salesforceData) {
    double temperature = salesforceData['temp'];
    city = salesforceData['city'];
    temp = temperature.toInt();
    if (city == "Mountain View") {
      city = "Mountain View";
    } else if (city.isEmpty && temp > 35) {
      city = "Someplace that's burning.";
    } else if (city.isEmpty && temp >= 28 && temp < 35) {
      city = "Someplace hot.";
    } else if (city.isEmpty && temp >= 20 && temp < 28) {
      city = "Someplace warm.";
    } else if (city.isEmpty && temp >= 10 && temp < 20) {
      city = "Someplace cool.";
    } else if (city.isEmpty && temp >= 8 && temp < 10) {
      city = "Someplace chilly.";
    } else if (city.isEmpty && temp >= 0 && temp < 8) {
      city = "Someplace cold.";
    } else if (city.isEmpty && temp >= -20 && temp < 0) {
      city = "Someplace freezing.";
    } else if (city.isEmpty && temp < -20) {
      city = "Someplace extremely cold.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Used for removing back buttoon.
          title: Text('Weather Report'),
          actions: [
            IconButton(
              icon: Image.asset('assets/postgre.png'),
              tooltip: 'Get Users',
              onPressed: () {
                // Navigator.pushNamed(context, '/users')
                //     .then((value) => setState(() {}));
                Navigator.pushReplacementNamed(context, '/users');
                // .then((value) => setState(() {}));
              },
            ),
            IconButton(
              icon: Image.asset('assets/astro-reg.png'),
              tooltip: 'Get SF Accounts',
              onPressed: () {
                // Navigator.pushNamed(context, '/users')
                //     .then((value) => setState(() {}));
                Navigator.pushReplacementNamed(context, '/accounts');
                // .then((value) => setState(() {}));
              },
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 200, 0, 20),
              child: Row(
                children: [
                  Text(
                    'Current Location :',
                    style: infotext,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 30),
              child: Row(children: <Widget>[
                Flexible(
                    child: Text(
                  city,
                  style: citytext,
                ))
              ]),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                children: [
                  Text(' $temp°C ',
                      style: TextStyle(
                          color: colorTempToRGB(temp),
                          fontWeight: FontWeight.bold,
                          fontSize: 75)),
                ],
              ),
            )
          ],
        ));
  }
}
