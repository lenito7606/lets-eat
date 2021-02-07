import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userlistpage extends StatelessWidget {
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
            builder: (context) => Center(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Login Screen App'),
                  ),
                  body: new Column(
                    children: <Widget>[
                      Container(height: 50),
                      Text('Data Retrieved from Firebase Below'),
                      new Flexible(
                        child: _buildBody(context),
                      )
                    ],
                  ),
                ))));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.userName),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.userName),
          trailing: Text(record.password),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Record {
  final String userName;
  final String password;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['username'] != null),
        assert(map['password'] != null),
        userName = map['username'],
        password = map['password'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$userName:$password>";
}