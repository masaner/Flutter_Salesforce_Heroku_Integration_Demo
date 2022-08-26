// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:student_management/models/account_location.dart';
import 'package:student_management/models/accounts_from_heroku.dart';
import 'package:student_management/models/accounts_from_sf.dart';
import 'package:student_management/models/environment.dart';
import 'package:student_management/models/users.dart';
import 'dart:convert';
import 'package:avatar_view/avatar_view.dart';
import 'package:http/http.dart' as http;

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  List<Users>? users;
  List<Accounts>? accounts;
  List<SfAccounts>? sfaccounts;
  String? lat, lon;

  late String access_token = '', token_type = '';
  late String data;

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Removes back button.
          title: Text('Accounts from Heroku'),
          actions: [
            IconButton(
              icon: const Icon(Icons.cloud_outlined),
              tooltip: 'Get Weather Report',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/weather');
              },
            ),
            IconButton(
              // icon: const Icon(Icons.radar),
              icon: Image.asset('assets/astro-reg.png'),
              tooltip: 'Get SF Accounts',
              onPressed: () async {
                accounts = null;
                setState(() {});
                await Future.delayed(Duration(seconds: 1));
                Navigator.pushReplacementNamed(context, '/accounts');
              },
            )
          ],
        ),
        body: accounts == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String fullname =
                      '${accounts?[index].firstName} ${accounts?[index].lastName}';
                  return ListTile(
                    title: Text(fullname),
                    subtitle: Text('Username: ${accounts?[index].username}'),
                    leading: AvatarView(
                        radius: 20,
                        borderWidth: 4,
                        borderColor: Color.fromARGB(255, 188, 113, 231),
                        avatarType: AvatarType.CIRCLE,
                        imagePath: "assets/userPicture.png",
                        placeHolder: Icon(
                          Icons.person,
                          size: 40,
                        )),
                    onTap: () {
                      setState(() {
                        print('${accounts?[index].firstName} Clicked!');
                        print(
                            '${accounts?[index].lat} ${accounts?[index].lon}');

                        Navigator.pushReplacementNamed(
                          context,
                          '/weather',
                          arguments: AccountLocation(
                            accounts?[index].lat,
                            accounts?[index].lon,
                          ),
                        );
                      });
                    },
                    onLongPress: () {
                      print('${accounts?[index].firstName}  Long Pressed!');
                      // Navigator.pushReplacementNamed(context, '/newscreen');
                    },
                  );
                },
                itemCount: accounts?.length,
              ));
  }

  Future<void> getAllUsers() async {
    Uri url = Uri.https(Environment.herokuURL, '/accounts');
    http.Response res = await http.get(url);
    List<dynamic> body = jsonDecode(res.body);
    accounts = body.map((dynamic item) => Accounts.fromJson(item)).toList();
    setState(() {});
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
}
