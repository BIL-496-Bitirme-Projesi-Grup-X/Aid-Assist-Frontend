import 'dart:convert';

import 'package:aid_assist/models/user.dart';
import 'package:aid_assist/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  Future<User> futureUser;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final nationalIdController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    surnameController.dispose();
    nationalIdController.dispose();
    super.dispose();
  }

  Future<User> fetchUser() async {
    var auth = Provider.of<Auth>(context, listen: false);

    final response = await http
        .get(Uri.http(Auth.hostAddress, 'user/' + auth.userId), headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Bearer " + auth.token
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      User user = userFromJson(response.bodyBytes);
      nameController.text = user.name;
      surnameController.text = user.surname;
      nationalIdController.text = user.nationalIdentityNo;
      return userFromJson(response.bodyBytes);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      auth.logout();
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateUser(String id, String name, String surname) async {
    var auth = Provider.of<Auth>(context, listen: false);

    try {
      final response = await http.post(
        // If the backend and frontend codes run on the same Wi-Fi, then host machine ip can be used for physical phones
        // It is needed to change from 192.168.0.x to host machine ip.
        Uri.http(Auth.hostAddress, 'user/update'),

        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Bearer " + auth.token
        },
        body: json.encode({
          'nationalIdentityNo': id,
          'name': name,
          'surname': surname,
        }),
      );
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    futureUser = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      child: FutureBuilder<User>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Column(
              children: [
                new ListTile(
                  leading: SizedBox(
                      width: 50,
                      child: Text("Ad",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ))),
                  title: SizedBox(
                      width: 200,
                      child: new TextFormField(
                        controller: nameController,
                        decoration: new InputDecoration(fillColor: Colors.red),
                      )),
                ),
                new ListTile(
                  leading: SizedBox(
                      width: 50,
                      child: Text("Soyad",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ))),
                  title: SizedBox(
                      width: 200,
                      child: new TextFormField(
                        controller: surnameController,
                        decoration: new InputDecoration(
                            hintText: "Name", fillColor: Colors.red),
                      )),
                ),
                new ListTile(
                  leading: SizedBox(
                      width: 50,
                      child: Text("Tc No",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal,
                          ))),
                  title: SizedBox(
                      width: 200,
                      child: new TextFormField(
                        readOnly: true,
                        controller: nationalIdController,
                        decoration: new InputDecoration(
                            hintText: "Name", fillColor: Colors.red),
                      )),
                ),
                const Divider(
                  height: 1.0,
                ),
                ElevatedButton(
                  child: Text('Güncelle'),
                  onPressed: () {
                    updateUser(nationalIdController.text, nameController.text,
                        surnameController.text);
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
