// To parse this JSON data, do
//
//     final accounts = accountsFromJson(jsonString);

import 'dart:convert';

List<Accounts> accountsFromJson(String str) =>
    List<Accounts>.from(json.decode(str).map((x) => Accounts.fromJson(x)));

String accountsToJson(List<Accounts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Accounts {
  Accounts({
    this.id = 0,
    this.username = '',
    this.firstName = '',
    this.lastName = '',
    this.lon = '',
    this.lat = '',
  });

  int id;
  String username;
  String firstName;
  String lastName;
  String lon;
  String lat;

  factory Accounts.fromJson(Map<String, dynamic> json) => Accounts(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        lon: json["lon"],
        lat: json["lat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "lon": lon,
        "lat": lat,
      };
}
