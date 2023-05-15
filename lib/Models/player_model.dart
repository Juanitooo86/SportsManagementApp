import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerModel {
  String? playerId;
  String? firstName;
  String? lastName;
  int? age;

  PlayerModel({this.playerId, this.firstName, this.lastName, this.age});

  PlayerModel.playerDataFromSnapshot(DocumentSnapshot snapshot) {
    playerId = snapshot.id;
    firstName = snapshot.get('firstName');
    lastName = snapshot.get('lastName');
    age = snapshot.get('age');
    //role: snapshot.get('role'),
  }
}
