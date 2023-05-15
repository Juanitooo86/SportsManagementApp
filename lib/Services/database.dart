//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/fixture_model.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Models/player_profile_model.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Models/player_profile_model.dart';
import 'package:flutter/services.dart';

class DatabaseService {
  final String? uid;
  final String? teamId;
  final String? playerId;
  DatabaseService({this.uid, this.teamId, this.playerId});

  // collecion ref
  final CollectionReference playerCollection =
      FirebaseFirestore.instance.collection('players');

  final CollectionReference teamCollection =
      FirebaseFirestore.instance.collection('teams');

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // update player data
  Future updateUserData(String? firstName, String? lastName, int age,
      String teamId, String role) async {
    return await playerCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'teamId': teamId,
      'role': role
    });
  }

  // update user data in settingz
  Future updateUserDataInSettingz(
    String? firstName,
    String? lastName,
    int age,
  ) async {
    return await playerCollection.doc(uid).update({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    });
  }

  //add player to a team

  Future addPlayerToTeam(
    String? teamId,
    String? firstName,
    String? lastName,
    int age,
    int rating,
    String? profile,
  ) async {
    String retVal = 'error';
    try {
      DocumentReference _docRef =
          await teamCollection.doc(teamId).collection('teamPlayers').add({
        'firstName': firstName,
        'lastName': lastName,
        'age': age,
      });
      await teamCollection
          .doc(teamId)
          .collection('teamPlayers')
          .doc(_docRef.id)
          .collection('playerProfile')
          .add({
        'playerId': _docRef.id,
        'profile': profile,
        'rating': rating,
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  //add fixture to the team
  Future addFixtureToTeam(
      String? teamId, String? opponent, String? place, Timestamp date) async {
    try {
      //DocumentReference _docRef2 =
      await teamCollection.doc(teamId).collection('fixtures').add({
        'opponent': opponent,
        'place': place,
        'date': date,
      });
    } catch (e) {
      print(e);
    }
  }

//add dummy profile for player

  // Future addProfileToPlayer(
  //   String? playerId,
  //   int rating,
  //   String? profile,
  // ) async {
  //   return await teamCollection
  //       .doc(teamId)
  //       .collection('teamPlayers')
  //       .doc(playerId)
  //       .collection('playerProfile')
  //       .add({
  //     'profile': profile,
  //     'rating': rating,
  //   });
  // }

  // update team data
  // Future createTeamData(String userUid, String teamName) async {
  //   List<String> members = [];
  //   members.add(userUid);
  //   return await teamCollection.doc(uid).set({
  //     'teamName': teamName,
  //     'manager': userUid,
  //     'members': members,
  //   });
  // }

  //player list from collection

  // Future listPlayers<DocumentSnapshot>(
  //   return await playerCollection.doc(uid).get(););

  //player list from snapshots
  List<PlayerModel> _playerListFromSnapshot(QuerySnapshot snapshot1) {
    return snapshot1.docs.map((doc2) {
      return PlayerModel(
          firstName: doc2.get('firstName') ?? '',
          lastName: doc2.get('lastName') ?? '',
          age: doc2.get('age') ?? 0);
    }).toList();
  }

//get players stream
  Stream<List<PlayerModel>> get players {
    return teamCollection.snapshots().map(_playerListFromSnapshot);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        firstName: snapshot.get('firstName'),
        lastName: snapshot.get('lastName'),
        age: snapshot.get('age'),
        teamId: snapshot.get('teamId'),
        role: snapshot.get('role'));
  }

  //get user doc stream
  Stream<UserData> get userData {
    return playerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //teamId from snapshot

  Future<String> getTeamId(DocumentReference docRef) async {
    DocumentSnapshot snapshot3 = await docRef.get();
    var docId2 = snapshot3.reference.id;
    return docId2;
  }

  //get players from current team
  Future<List<PlayerModel>> getTeamPlayers(String teamId) async {
    List<PlayerModel> retVal = [];
    try {
      QuerySnapshot query = await _firestore
          .collection('teams')
          .doc(teamId)
          .collection('teamPlayers')
          .orderBy('lastName', descending: false)
          .get();

      query.docs.forEach((element) {
        retVal.add(PlayerModel.playerDataFromSnapshot(element));
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  //get fixtures from current team
  Future<List<FixtureModel>> getTeamFixtures(String teamId) async {
    List<FixtureModel> retVal = [];
    try {
      QuerySnapshot query = await _firestore
          .collection('teams')
          .doc(teamId)
          .collection('fixtures')
          .orderBy('date', descending: false)
          .get();

      query.docs.forEach((element) {
        retVal.add(FixtureModel.fixtureDataFromSnapshot(element));
      });
    } catch (e) {
      print(e);
    }
    return retVal;
  }

//get player profile
  // Future<PlayerProfileModel> getPlayerProfile(
  //     String teamId, String playerId) async {
  //   PlayerProfileModel retVal = new PlayerProfileModel();
  //   try {
  //     DocumentSnapshot _documentSnapshot = await _firestore
  //         .collection('teams')
  //         .doc(teamId)
  //         .collection('teamPlayers')
  //         .doc(playerId)
  //         .get();

  //     retVal = PlayerProfileModel.playerProfileFromSnapshot(
  //         snapshot: _documentSnapshot);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return retVal;
  // }

//player profile from stream
  PlayerProfileModelData _playerProfileDataFromSnapshot(
      DocumentSnapshot snapshot) {
    return PlayerProfileModelData(
        teamId: teamId,
        rating: snapshot.get('rating'),
        //teamId: snapshot.get('teamId'),
        profile: snapshot.get('profile'));
  }

  //get profile doc stream
  Stream<PlayerProfileModelData> get playerProfileData {
    return teamCollection
        .doc(teamId)
        .collection('teamPlayers')
        .doc(playerId)
        .snapshots()
        .map(_playerProfileDataFromSnapshot);
  }

  // UserModel _teamIdFromSnapshot(DocumentSnapshot snapshot1) {
  //   return UserModel(
  //     uid: uid,
  //     teamId: snapshot1.get('teamId'),
  //   );
  // }

  // //get teamId
  // Stream<UserModel> get currentTeamId {
  //   return playerCollection.doc(uid).snapshots().map(_teamIdFromSnapshot);
  // }

  // Stream<UserData> get userData {
  //   return playerCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }

  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //       uid: uid,
  //       firstName: snapshot.get('firstName'),
  //       lastName: snapshot.get('lastName'),
  //       age: snapshot.get('age'),
  //       teamId: snapshot.get('teamId'),
  //       role: snapshot.get('role'));
  // }
}
