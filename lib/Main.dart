import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'RegistrationPage.dart';
import 'HomePage.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  Future<bool> isAccountValid() async {
    bool userNameFound = false;
    bool passwordFound = false;
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("users").getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      a.data.forEach((key, value) {
        if (key == 'username' && value == loginUserNameController.text) {
          userNameFound = true;
        }
        if (key == 'password' && value == loginPasswordController.text) {
          passwordFound = true;
        }
      });
    }

    return userNameFound && passwordFound ? Future<bool>.value(true) : Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Center(
                    child: Scaffold(
                  appBar: AppBar(
                    title: Text("Let's Eat!"),
                  ),
                  body: new Column(
                    children: <Widget>[
                      new Container(
                          child: Center(
                              child: Column(children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationForm()),
                            );
                            //Registration Form screen
                          },
                          textColor: Colors.blue,
                          child: Text('Register'),
                        ),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: loginUserNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              obscureText: true,
                              controller: loginPasswordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            )),
                        FlatButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          child: Text('Forgot Password'),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                              onPressed: () async {
                                if (loginUserNameController.text.isEmpty ||
                                    loginPasswordController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Required Information",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  if (await isAccountValid()) {
                                    Fluttertoast.showToast(
                                        msg: "Login Success",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(loginUserName: loginUserNameController.text)));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Login Failed",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              },
                              // Login button
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Login'),
                            )),
                      ])))
                    ],
                  ),
                ))));
  }
}
