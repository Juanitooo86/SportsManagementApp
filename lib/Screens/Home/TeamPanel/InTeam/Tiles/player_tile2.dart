import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_profile_model.dart';
import 'package:flutter_sports_app/Screens/Home/player_profile.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';

class PlayerTile2 extends StatelessWidget {
  //const PlayerTile2({super.key});
  final PlayerModel? playerTile2;
  final String? teamId;

  void _goToPlayerProfile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerProfile(
            teamId: teamId,
            playerId: playerTile2?.playerId,
          ),
        ));
  }

  PlayerTile2({this.playerTile2, this.teamId});

  String? _profile;
  int? _rating = 0;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //     child: Column(
    //   children: [Text(playerTile2!.firstName!), Text(playerTile2!.lastName!)],
    // ));

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.yellow[200],
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20, 0.0),
        child: Column(
          children: [
            ListTile(
              //tileColor: Colors.yellow[200],
              //tileColor: Colors.yellow[playerTile2!.age!],
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.blue[playerTile2!.age!],
                //backgroundImage: AssetImage('assets/coffee_icon.png'),
                backgroundImage: NetworkImage(
                    'https://source.unsplash.com/random?sig=${playerTile2!.firstName}'),
              ),
              title: Text(
                '${playerTile2!.age!} y.o.',
                style: TextStyle(fontSize: 15, color: Colors.grey
                    //fontWeight: FontWeight.bold,
                    ),
              ),
              //subtitle: Text('$playerTile2'),
              trailing: Text(
                '${playerTile2!.firstName!} ' ' ${playerTile2!.lastName!}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () async {
                  _goToPlayerProfile(context);
                },
                icon: Icon(Icons.account_circle),
                label: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
