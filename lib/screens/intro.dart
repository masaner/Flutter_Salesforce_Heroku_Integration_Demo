import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_management/models/environment.dart';
import 'package:student_management/models/location.dart';
import 'package:student_management/models/account_location.dart';
import 'package:student_management/screens/weather.dart';
import 'package:http/http.dart' as http;

class IntroScreen extends StatefulWidget {
  // const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  double? lat, lon, temperature;
  String? city;
  late String access_token = '', token_type = '';
  late String data;

  @override
  void initState() {
    callme();
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
  }

  Future<Map<String, String>> getLocation() async {
    Location location = Location();
    await location.getLocation();
    var cordinates = new Map<String, String>();
    cordinates['lat'] = location.lat.toString();
    cordinates['lon'] = location.lon.toString();
    return cordinates;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Used for removing back buttoon.
          title: Text('Weather Report'),
        ),
        body: Center(child: CircularProgressIndicator()));
  }

  callme() async {
    await Future.delayed(Duration(seconds: 3));
    getData().then((value) => {
          if (value == null)
            {getDataCurrentLocation()}
          else
            {getDataPredefinedLocation(value.lat, value.lon)}
        });
  }

  Future getData() async {
    final AccountLocation? arg =
        ModalRoute.of(context)?.settings.arguments as AccountLocation?;
    return arg;
  }

  Future<dynamic> getWeather(
      String lat, String lon, String accessToken, String tokenType) async {
    var headers = {
      'Content-Type': 'application/json',
      'authorization': '$tokenType $accessToken'
    };
    final body = {'lat': lat, 'lon': lon};
    try {
      final response = await http.post(
          Uri.parse('${Environment.instance_url}/services/apexrest/Weather/'),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 401) {}
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to return Data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to reach Salesforce. No Request');
    }
  }

  Future<dynamic> getToken() async {
    var headerData = new Map<String, String>();
    headerData['Content-Type'] = 'application/x-www-form-urlencoded';
    headerData['Accept'] = 'application/json';

    var bodyData = new Map<String, dynamic>();
    bodyData['grant_type'] = 'password';
    bodyData['client_id'] = Environment.client_id;
    bodyData['client_secret'] = Environment.client_secret;
    bodyData['username'] = Environment.username;
    bodyData['password'] =
        '${Environment.password}${Environment.security_token}';
    try {
      final response = await http.post(
        Uri.parse('${Environment.instance_url}/services/oauth2/token'),
        headers: headerData,
        body: bodyData,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token_type = data['token_type'];
        access_token = data['access_token'];
        return data;
      } else {
        throw Exception(
            'Failed to return Data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to reach Salesforce. No Request');
    }
  }

  Future<void> getDataCurrentLocation() async {
    dynamic response = await getToken();
    dynamic location = await getLocation();
    String latitude = location['lat'].toString();
    String longitude = location['lon'].toString();
    String accessToken = response['access_token'].toString();
    String tokenType = response['token_type'].toString();
    dynamic salesforceData =
        await getWeather(latitude, longitude, accessToken, tokenType);
    temperature = salesforceData['temp'];
    city = salesforceData['city'];
    pushData(salesforceData);
  }

  Future<void> getDataPredefinedLocation(String? lat, String? lon) async {
    dynamic response = await getToken();
    String? latitude = lat;
    String? longitude = lon;
    String accessToken = response['access_token'].toString();
    String tokenType = response['token_type'].toString();
    dynamic salesforceData =
        await getWeather(latitude!, longitude!, accessToken, tokenType);
    temperature = salesforceData['temp'];
    city = salesforceData['city'];
    pushData(salesforceData);
  }

  void pushData(dynamic salesforceData) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return WeatherPage(
        weatherData: salesforceData,
      );
    }));
  }
}


/* 
  
  FIXME: 
  -
  -
  -
  -
  
  TODO: 
  -
  -
  -
  -

 */
