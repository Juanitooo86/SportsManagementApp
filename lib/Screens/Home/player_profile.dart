import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Models/player_profile_model.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:provider/provider.dart';

class PlayerProfile extends StatefulWidget {
  //const PlayerProfile({super.key});

  final String? teamId;
  final String? playerId;

  PlayerProfile({this.teamId, this.playerId});

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
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

    final userForPlayerProfile = Provider.of<PlayerProfileModel?>(context);
    final user3 = FirebaseAuth.instance.currentUser!;
    final AuthService _auth = AuthService();

    return StreamBuilder<PlayerProfileModelData>(
        stream: DatabaseService(teamId: userForPlayerProfile?.teamId)
            .playerProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            PlayerProfileModelData? playerProfileData = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.green[400],
                  elevation: 10.0,
                  title: Text(user3.email!), //current user logged in
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
              body: SizedBox.expand(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/coffee_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                      child: Text('Vasya' '${playerProfileData!.rating!} ')),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
