import 'package:cloud_firestore/cloud_firestore.dart';

class FixtureModel {
  String? playerId;
  String? opponent;
  String? place;
  Timestamp? date;

  FixtureModel({this.playerId, this.opponent, this.place, this.date});

  FixtureModel.fixtureDataFromSnapshot(DocumentSnapshot snapshot) {
    playerId = snapshot.id;
    opponent = snapshot.get('opponent');
    place = snapshot.get('place');
    date = snapshot.get('date');
    //role: snapshot.get('role'),
  }
}
