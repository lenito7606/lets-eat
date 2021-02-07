import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationForm extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> validateUserName() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("users").getDocuments();
    if(Future<bool>.value() == null) {
      return false;
    }
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var a = querySnapshot.documents[i];
      a.data.forEach((key, value) {
        if (key == 'username' && value == userNameController.text) {
          return Future<bool>.value(true);
        }
      });
    }
    return Future<bool>.value(false);
  }

  void addData() async {
    Firestore.instance
        .collection("users")
        .add({
          'username': userNameController.text,
          'lastname': lastNameController.text,
          'firstname': firstNameController.text,
          'password': passwordController.text,
        })
        .then((value) => Fluttertoast.showToast(
            msg: "Registation Complete",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
            builder: (context) => Center(
                    child: Scaffold(
                  appBar: AppBar(
                    title: Text('Registration Form'),
                  ),
                  body: new Column(
                    children: <Widget>[
                      new Container(
                          child: Center(
                              child: Column(children: <Widget>[
                        Text(
                          'Registration',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Firstname',
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Lastname',
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: userNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.all(20),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            )),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                                onPressed: () async {
                                  if (firstNameController.text == null ||
                                      firstNameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Firstname",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (lastNameController.text == null ||
                                      lastNameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Lastname",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (userNameController.text == null ||
                                      userNameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Username",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (passwordController.text == null ||
                                      passwordController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please Enter Password",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else if (passwordController.text == null ||
                                      passwordController.text.isEmpty &&
                                          userNameController.text == null ||
                                      userNameController.text.isEmpty &&
                                          lastNameController.text == null ||
                                      lastNameController.text.isEmpty &&
                                          firstNameController.text == null ||
                                      firstNameController.text.isEmpty) {

                                    Fluttertoast.showToast(
                                        msg: "An Error has occured. Please contanct System Administrator",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    if (await validateUserName()) {
                                      Fluttertoast.showToast(
                                          msg: "Account already exists!",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Navigator.pop(context);
                                      addData();
                                    }
                                  }
                                },
                                // Login button
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: Text('Register'))),
                      ]))),
                    ],
                  ),
                ))));
  }
}