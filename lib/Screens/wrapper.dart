import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Screens/Authenticate/authenticate.dart';
import 'package:flutter_sports_app/Screens/Home/home.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/NotInTeam/not_in_team.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/team_panel_3.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/team_players_list.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return Home or Auth
    //final user2 = Provider.of<UserModel?>(context);
    UserModel? user2 = Provider.of<UserModel?>(context);

    print(user2?.teamId);
    print(user2?.uid);

    if (user2 != null) {
      // if (user2.teamId == '') {
      //   return const NotInTeam();
      // } else {
      return TeamPanel();
      // }
    } else {
      return const Authenticate();
    }
  }
}
