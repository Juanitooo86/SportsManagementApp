// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/create_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/join_team.dart';
//import 'package:flutter_sports_app/Screens/Home/settings_form.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/team_screen.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_sports_app/Screens/Home/1stInc/player_list.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/not_in_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/team_players_list.dart';
import 'package:flutter_sports_app/Screens/Home/player_profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user2 = Provider.of<UserModel?>(context);
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => NotInTeam(),
        '/teamScreen': (context) => TeamScreen2(),
        '/joinTeam/': (context) => JoinTeam(),
        '/createTeam/': (context) => CreateTeam(),
        '/playerProfile': (context) => PlayerProfile(),
        //'/playerListFromTeam': (context) => PlayerListFromTeam(),
      },
    );
  }
}
