// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Screens/Home/home.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/team_screen.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/team_players_list.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:flutter_sports_app/Screens/Home/settings_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:provider/provider.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  void _createTeam(BuildContext context, String teamName) async {
    final user4 = FirebaseAuth.instance.currentUser!;

    String returnString = await AuthService().createTeam(teamName, user4.uid);
    print(returnString);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TeamScreen2()),
      (route) => false,
    );
  }

  TextEditingController _teamNameController = TextEditingController();

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

    return Scaffold(
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
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
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
                'Create a Team',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.amber[400],
                ),
              ),
              const SizedBox(height: 20.0),
              // ignore: prefer_const_constructors
              Text(
                'Hello, please Create a team',
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _teamNameController,
                decoration: textInputDecor.copyWith(
                    prefixIcon: Icon(Icons.create_new_folder),
                    hintText: 'Enter Team name'),
                validator: (val3) =>
                    val3!.isEmpty ? "Enter a teamt name" : null,
                onChanged: (val1) {},
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _createTeam(context, _teamNameController.text),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.brown,
                  backgroundColor: Colors.yellow,
                ),
                child: Text('Create'),
              ),
            ])),
          ),
        ),
      ),
    );
  }
}
