import 'package:flutter/material.dart';
import 'package:student_management/models/account_location.dart';
import 'package:student_management/models/accounts_from_sf.dart';
import 'dart:convert';
import 'package:avatar_view/avatar_view.dart';
import 'package:http/http.dart' as http;
import 'package:student_management/models/environment.dart';

class AllSFUsers extends StatefulWidget {
  const AllSFUsers({Key? key}) : super(key: key);

  @override
  _AllSFUsersState createState() => _AllSFUsersState();
}

class _AllSFUsersState extends State<AllSFUsers> {
  List<SfAccounts>? sfaccounts;
  String? lat, lon;

  late String access_token = '', token_type = '';
  late String data;

  @override
  void initState() {
    getSalesforceAccounts();
    super.initState();
  }

  @override
  void dispose() {
    print('Dispose used');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final String? arg = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Removes back button.
          title: Text('Accounts from Salesforce'),
          actions: [
            IconButton(
              icon: const Icon(Icons.cloud_outlined),
              tooltip: 'Get Weather Report',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/weather');
              },
            ),
            IconButton(
              icon: Image.asset('assets/postgre.png'),
              tooltip: 'Get Users',
              onPressed: () async {
                sfaccounts = null;
                setState(() {});
                await Future.delayed(Duration(seconds: 1));
                Navigator.pushReplacementNamed(context, '/users');
              },
            )
          ],
        ),
        body: sfaccounts == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  String fullname = '${sfaccounts?[index].name}';
                  return ListTile(
                    title: Text(fullname),
                    subtitle: Text('Username: ${sfaccounts?[index].email}'),
                    leading: AvatarView(
                        radius: 20,
                        borderWidth: 2,
                        borderColor: Color.fromARGB(255, 42, 123, 245),
                        avatarType: AvatarType.RECTANGLE,
                        imagePath: "assets/userPicture.png",
                        placeHolder: Icon(
                          Icons.person,
                          size: 40,
                        )),
                    // leading: CircleAvatar(
                    //     backgroundImage: NetworkImage()),
                    onTap: () {
                      setState(() {
                        print('${sfaccounts?[index].name} Clicked!');
                        print(
                            '${sfaccounts?[index].locationC?.latitude} ${sfaccounts?[index].locationC?.longitude}');

                        Navigator.pushReplacementNamed(
                          context,
                          '/weather',
                          arguments: AccountLocation(
                            sfaccounts?[index].locationC?.latitude.toString(),
                            sfaccounts?[index].locationC?.longitude.toString(),
                          ),
                        );
                      });
                    },
                    onLongPress: () {
                      print('${sfaccounts?[index].name}  Long Pressed!');
                      // Navigator.pushReplacementNamed(context, '/newscreen');
                    },
                  );
                },
                itemCount: sfaccounts?.length,
              ));
  }

  Future<void> getSalesforceAccounts() async {
    await getToken();
    var headers = {'authorization': '$token_type $access_token'};
    try {
      final response = await http.get(
        Uri.parse('${Environment.instance_url}/services/apexrest/Accounts/'),
        headers: headers,
      );
      if (response.statusCode == 401) {}
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        List<dynamic> body = jsonDecode(response.body);
        sfaccounts =
            body.map((dynamic item) => SfAccounts.fromJson(item)).toList();
        setState(() {});
        // return data;
      } else {
        throw Exception(
            'Failed to return Data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to reach Salesforce. No Request');
    }
  }

  Future<void> getToken() async {
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
