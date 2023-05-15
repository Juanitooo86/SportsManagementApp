import 'package:flutter_sports_app/Models/fixture_model.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_profile_model.dart';
import 'package:flutter_sports_app/Screens/Home/player_profile.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FixtureTile extends StatelessWidget {
  //const PlayerTile2({super.key});
  final FixtureModel? fixtureTile;
  final String? teamId;

  // void _goToPlayerProfile(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => PlayerProfile(
  //           teamId: teamId,
  //           playerId: playerTile2?.playerId,
  //         ),
  //       ));
  // }

  FixtureTile({this.fixtureTile, this.teamId});

  //String formattedDate = DateFormat.yMMMEd().format(fixtureTile!.date!);

  @override
  Widget build(BuildContext context) {
    //String formattedDate = DateFormat.yMMMEd().format(fixtureTile!.date!);
    Timestamp t = fixtureTile!.date!;
    DateTime d = t.toDate();
    String formated = DateFormat('E d MMM H:mm').format(d);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.yellow[200],
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20, 0.0),
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Text(
                fixtureTile!.opponent!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(fixtureTile!.place!),
              trailing: Text(
                formated,
                style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton.icon(
            //     onPressed: () async {
            //      // _goToPlayerProfile(context);
            //     },
            //     icon: Icon(Icons.account_circle),
            //     label: Text('Profile'))
          ],
        ),
      ),
    );
  }
}
