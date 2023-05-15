// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/create_team.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/player_list.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/not_in_team.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.blue[100],
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
              // child: const Text('Bottom sheetTTTT'),
              child: SettingsForm(),
            );
          });
    }

    final user3 = FirebaseAuth.instance.currentUser!;
    final AuthService _auth = AuthService();

    return StreamProvider<List<PlayerModel>?>.value(
      value: DatabaseService().players,
      initialData: [],
      child: Scaffold(
        //backgroundColor: Colors.green[50],
        appBar: AppBar(
            backgroundColor: Colors.green[400],
            elevation: 10.0,
            title: Text(user3.email!),
            actions: <Widget>[
              TextButton.icon(
                  icon: Icon(Icons.logout),
                  label: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOUtZ();
                  }),
              TextButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () => _showSettingsPanel(),
              )
            ]),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),

          //create if statement for user with/without team
          child: PlayerList(),
          // child: NotInTeam(),
          //child: CreateTeam(),
        ),
      ),
    );
  }
}
