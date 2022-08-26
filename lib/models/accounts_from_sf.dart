// To parse this JSON data, do
//
//     final sfAccounts = sfAccountsFromJson(jsonString);

import 'dart:convert';

List<SfAccounts> sfAccountsFromJson(String str) =>
    List<SfAccounts>.from(json.decode(str).map((x) => SfAccounts.fromJson(x)));

String sfAccountsToJson(List<SfAccounts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SfAccounts {
  SfAccounts({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.lat = 0,
    this.lon = 0,
    this.isDemo = true,
    this.locationC,
  });

  String? name;
  String? phone;
  String? email;
  double? lat;
  double? lon;
  bool? isDemo;
  LocationC? locationC;

  factory SfAccounts.fromJson(Map<String, dynamic> json) => SfAccounts(
        name: json["Name"],
        phone: json["Phone"],
        email: json["Email__c"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        isDemo: json["IsDemo__c"],
        locationC: LocationC.fromJson(json["Location__c"]),
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Phone": phone,
        "Email__c": email,
        "lat": lat,
        "lon": lon,
        "IsDemo__c": isDemo,
        "Location__c": locationC?.toJson()
      };
}

class LocationC {
  LocationC({
    required this.latitude,
    required this.longitude,
  });

  double latitude;
  double longitude;

  factory LocationC.fromJson(Map<String, dynamic> json) => LocationC(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
