//import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerProfileModel {
  final String? teamId;
  final String? playerId;

  PlayerProfileModel({this.teamId, this.playerId});
}

class PlayerProfileModelData {
  String? teamId;
  String? profile;
  int? rating;

  PlayerProfileModelData({
    this.teamId,
    this.profile,
    this.rating,
  });

  // PlayerProfileModel.playerProfileFromSnapshot({DocumentSnapshot? snapshot}) {
  //   teamId = snapshot!.id;
  //   profile = snapshot.get('profile');
  //   rating = snapshot.get('rating');
  // }
}
