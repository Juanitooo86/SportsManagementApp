import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/player_model.dart';

class PlayerTile extends StatelessWidget {
  const PlayerTile({Key? key, required this.playerTile}) : super(key: key);

  final PlayerModel playerTile;
  //PlayerTile({this.player2});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20, 0.0),
        child: ListTile(
          tileColor: Colors.yellow[200],
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[playerTile.age!],
            //backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundImage: NetworkImage(
                'https://source.unsplash.com/random?sig=${playerTile.firstName}'),
          ),
          title: Text('${playerTile.age!} years old'),
          subtitle: Text('$playerTile'),
          trailing:
              Text('${playerTile.firstName!} ' ' ${playerTile.lastName!}'),
        ),
      ),
    );
  }
}
