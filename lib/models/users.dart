import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.deviceId = '',
    this.username = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.testResult = '',
    this.testDate = '',
    this.degree = '',
    this.course1 = false,
    this.course2 = false,
    this.course3 = false,
    this.course4 = false,
    this.course5 = false,
  });

  String? deviceId;
  String? username;
  String? password;
  String? firstName;
  String? lastName;
  String? testResult;
  String? testDate;
  String? degree;
  bool? course1;
  bool? course2;
  bool? course3;
  bool? course4;
  bool? course5;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        deviceId: json["device_id"],
        username: json["username"],
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        testResult: json["test_result"],
        testDate: json["test_date"],
        degree: json["degree"],
        course1: json["course_1"],
        course2: json["course_2"],
        course3: json["course_3"],
        course4: json["course_4"],
        course5: json["course_5"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "username": username,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "test_result": testResult,
        "test_date": testDate,
        "degree": degree,
        "course_1": course1,
        "course_2": course2,
        "course_3": course3,
        "course_4": course4,
        "course_5": course5,
      };
}
