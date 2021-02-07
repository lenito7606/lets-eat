import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lets_eat/UserListPage.dart';

import 'Main.dart';

class HomePage extends StatelessWidget {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(34.6777645, 135.4160249); //Osaka

  final TextEditingController loginUserNameController = TextEditingController();

  final String title;
  final String loginUserName;
  HomePage({Key key, this.title, this.loginUserName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Page')),
      body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0)),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('こんにちは "$loginUserNameさん"'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Member List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Userlistpage()));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    Main()), (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
