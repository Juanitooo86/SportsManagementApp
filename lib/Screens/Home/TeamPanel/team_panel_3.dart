import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Screens/Authenticate/authenticate.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/not_in_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/in_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/Tiles/player_tile2.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';

class TeamPanel extends StatefulWidget {
  final String? teamId;

  TeamPanel({
    this.teamId,
  });

  @override
  State<TeamPanel> createState() => _TeamPanelState();
}

class _TeamPanelState extends State<TeamPanel> {
  late Future<List<PlayerModel>> players2;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.green[900],
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
              // child: const Text('Bottom sheetTTTT'),
              child: const SettingsForm(),
            );
          });
    }

    final user2 = Provider.of<UserModel?>(context);
    // final user3 = FirebaseAuth.instance.currentUser;
    final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user2?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData3 = snapshot.data;
            String? teamId1 = userData3?.teamId;
            players2 = DatabaseService().getTeamPlayers(teamId1!);

            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.green[400],
                  elevation: 10.0,
                  title: Text(userData3!.firstName!), //current user logged in
                  actions: <Widget>[
                    TextButton.icon(
                        icon: Icon(Icons.logout, color: Colors.red),
                        label: Text('Logout'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await _auth.signOUtZ();
                        }),
                    TextButton.icon(
                      icon: const Icon(Icons.settings, color: Colors.amber),
                      label: const Text('Settings'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.amber,
                      ),
                      onPressed: () => _showSettingsPanel(),
                    )
                  ]),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/football.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FutureBuilder(
                    future: players2,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PlayerModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print('team Id printed next line');
                        print(teamId1);
                        if (teamId1 != '') {
                          return const InTeam();
                        } else {
                          return const NotInTeam();
                        }
                      } else {
                        return const Loading();
                      }
                    }),
              ),
            );
          } else {
            return const Authenticate();
          }
        });
  }
}
