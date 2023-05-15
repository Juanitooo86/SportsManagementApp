import 'package:flutter_sports_app/Models/fixture_model.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/Tiles/fixture_tile.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/add_fixture.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/not_in_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/Tiles/player_tile2.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/team_panel_3.dart';
import 'package:flutter_sports_app/Services/database.dart';
//import 'package:flutter_sports_app/Screens/Home/1stInc/player_tile.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';

class FixturesList extends StatefulWidget {
  //const TeamScreen2({super.key});

  final String? teamId;

  FixturesList({
    this.teamId,
  });

  @override
  State<FixturesList> createState() => _FixturesListState();
}

class _FixturesListState extends State<FixturesList> {
  late Future<List<FixtureModel>> fixtures7;

  void _goToAddFixture(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => AddFixture(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // void _showSettingsPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //           color: Colors.blue[100],
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
    //           // child: const Text('Bottom sheetTTTT'),
    //           child: const SettingsForm(),
    //         );
    //       });
    // }

    final user7 = Provider.of<UserModel?>(context);
    //final user77 = FirebaseAuth.instance.currentUser!;
    // final AuthService _auth = AuthService();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user7?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData3 = snapshot.data;
            String? teamId1 = userData3?.teamId;
            fixtures7 = DatabaseService().getTeamFixtures(teamId1!);

            void _goToTeamPanel(BuildContext context) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamPanel(),
                  ),
                  (route) => false);
            }

            return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_rounded),
                      color: Colors.blue,
                      onPressed: () => _goToTeamPanel(context)),
                  backgroundColor: Colors.green[400],
                  elevation: 10.0,
                  title: Text(userData3!.firstName!), //current user logged in
                  actions: <Widget>[
                    TextButton.icon(
                        icon: Icon(Icons.more_time),
                        label: Text('Add Game'),
                        onPressed: () => _goToAddFixture(context)),
                    // TextButton.icon(
                    //   icon: const Icon(Icons.settings),
                    //   label: const Text('Settings'),
                    //   onPressed: () => _showSettingsPanel(),
                    // )
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
                    future: fixtures7,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<FixtureModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          teamId1 != '') {
                        print('team Id printed next line');
                        print(teamId1);

                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FixtureTile(
                                fixtureTile: snapshot.data![index],
                                //teamId: widget.teamId,
                                teamId: teamId1,
                              );
                            });
                      } else {
                        return const Loading();
                      }
                    }),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
