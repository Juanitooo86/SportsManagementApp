import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/fixtures_list.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/team_players_list.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/player_list.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';

class InTeam extends StatelessWidget {
  const InTeam({super.key});

  @override
  Widget build(BuildContext context) {
    void _goToPlayers(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeamScreen2(),
        ),
      );
    }

    void _goToFixtures(BuildContext context) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => FixturesList(),
          ),
          (route) => false);
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
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              //Image.asset('assets/coffee_icon.png'),
              Icon(
                Icons.sports_soccer,
                size: 200,
              ),
              const SizedBox(height: 5.0),
              Text(
                'Futsal App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.amber[400],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
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
                      onPressed: () => _goToPlayers(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.brown,
                        backgroundColor: Colors.yellow,
                      ),
                      child: Text('Players'),
                    ),
                    ElevatedButton(
                      onPressed: () => _goToFixtures(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Fixtures'),
                    ),
                    ElevatedButton(
                      onPressed: () => _goToFixtures(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.blue,
                      ),
                      child: Text('Gallery'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
