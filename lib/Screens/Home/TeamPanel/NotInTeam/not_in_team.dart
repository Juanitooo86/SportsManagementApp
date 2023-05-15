import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/create_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/join_team.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/player_list.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';

class NotInTeam extends StatelessWidget {
  const NotInTeam({super.key});

  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinTeam(),
        ),
      );
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTeam(),
        ),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/football.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _goToJoin(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.brown,
                  backgroundColor: Colors.yellow,
                ),
                child: Text('Join a team'),
              ),
              ElevatedButton(
                onPressed: () => _goToCreate(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.green,
                ),
                child: Text('Create a Team'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
