import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/team_screen.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/team_players_list.dart';

class JoinTeam extends StatefulWidget {
  const JoinTeam({super.key});

  @override
  State<JoinTeam> createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {
  String _currentFirstName = '';
  String _currentLastName = '';
  int? _currentAge = 10;
  TextEditingController _teamIdController = TextEditingController();
  //TextEditingController _ratingController = TextEditingController();
  TextEditingController _playerProfileController = TextEditingController();

  void _joinTeam(BuildContext context, String teamId) async {
    final user5 = FirebaseAuth.instance.currentUser!;
    String returnString = await AuthService().joinTeam(teamId, user5.uid);
    print(returnString);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TeamScreen2()),
      (route) => false,
    );
  }

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
    final userForJoin = Provider.of<UserModel?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userForJoin?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scaffold(
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
                        vertical: 30.0, horizontal: 50.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/football.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Form(
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                        Icon(
                          Icons.sports_soccer,
                          size: 200,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Join a Team',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.amber[400],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // ignore: prefer_const_constructors
                        Text(
                          'Hello, please Join a team',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          //team ID input
                          controller: _teamIdController,
                          decoration: textInputDecor.copyWith(
                              prefixIcon: Icon(Icons.groups),
                              hintText: 'Enter Team ID'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter a ID" : null,
                          onChanged: (val1) {},
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          //team ID input
                          controller: _playerProfileController,
                          decoration: textInputDecor.copyWith(
                              prefixIcon: Icon(Icons.groups),
                              hintText: 'Enter Player Profile'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter Player profile" : null,
                          onChanged: (val1) {},
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            // UserModel player = UserModel();
                            _joinTeam(context, _teamIdController.text);
                            await DatabaseService(uid: userForJoin?.uid)
                                .addPlayerToTeam(
                              _teamIdController.text,
                              userData?.firstName,
                              userData?.lastName,
                              userData?.age as int,
                              userData?.age as int,
                              _playerProfileController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.brown,
                            backgroundColor: Colors.yellow,
                          ),
                          child: Text('Join'),
                        ),
                      ])),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
