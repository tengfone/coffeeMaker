import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeemaker/models/brew.dart';
import 'package:coffeemaker/screens/home/settings_form.dart';
import 'package:coffeemaker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeemaker/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Maker'),
          backgroundColor: Colors.brown[400],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async{
                await _auth.signOut();
              },
              label: Text('Logout'),
            ),
            FlatButton.icon(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.settings), label: Text("Settings")),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
