import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Screens/Home/1stInc/player_tile.dart';

class PlayerList extends StatefulWidget {
  const PlayerList({super.key});

  @override
  State<PlayerList> createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<PlayerModel>?>(context) ?? [];

    //print(players!.docs);
    // if (players != null) {
    //  for (var doc1 in players.docs) {
    //    print(doc1.data());
    //  }
    // }
    // if (players != null) {
    //   players.forEach((player1) {
    //     print(player1.name);
    //     print(player1.sugars);
    //     print(player1.strength);
    //   });
    // }
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final item = players[index];
        return PlayerTile(playerTile: players[index]);
      },
    );
  }
}
