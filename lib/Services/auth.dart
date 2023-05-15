import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sports_app/Models/player_model.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Create userModel obj base on firebaseUser
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModel?> get user {
    return _auth
        .authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign in annnonimously
  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user!;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register a player
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String firstName,
      String lastName,
      int age,
      String teamId,
      String role) async {
    try {
      //create user
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      //create new doc for user with uid
      await DatabaseService(uid: user.uid)
          .updateUserData(firstName, lastName, age, teamId, role);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register a team
  // Future registerTeamWithEmailAndPassword(String email, String password,
  //     String managerFirstName, String managerLastName, String teamName) async {
  //   try {
  //     //create user
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User user = result.user!;
  //     //create new doc for user with uid
  //     await DatabaseService(uid: user.uid)
  //         .updateTeamData(managerFirstName, managerLastName, teamName);
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //Register a team from create button

  Future createTeam(String teamName, String userUid) async {
    String retVal = 'error';
    List<String> members = [];

    try {
      //members.add(userUid);
      DocumentReference _docRef = await _firestore.collection('teams').add({
        'teamName': teamName,
        'manager': userUid,
        'members': members,
      });
      await _firestore.collection('players').doc(userUid).update({
        'teamId': _docRef.id,
        'teamName': teamName,
        'role': 'manager',
      });

      retVal = 'succes';
    } catch (e) {
      print(e.toString());
      return null;
    }
    return retVal;
  }

  //join team

  Future joinTeam(String teamId, String userUid) async {
    List<String> members = [];
    String retVal = 'error';

    try {
      members.add(userUid);

      await _firestore.collection('teams').doc(teamId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection('players').doc(userUid).update({
        'teamId': teamId,
      });
      retVal = teamId;
      //add player to a team
      // await _firestore
      //     .collection('teams')
      //     .doc(teamId)
      //     .collection('players')
      //     .add({
      //   'firstName': player.firstName,
      //   'lastName': player.lastName,
      //   'age': player.age,
      // });
    } catch (e) {
      print(e.toString());
      return null;
    }
    return retVal;
  }

  // sign out
  Future signOUtZ() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
