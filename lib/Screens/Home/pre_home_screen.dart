// import 'package:flutter/material.dart';
// import 'package:flutter_sports_app/Models/user_model.dart';
// import 'package:flutter_sports_app/Screens/Authenticate/authenticate.dart';
// import 'package:flutter_sports_app/Screens/Home/home.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class PreHomeScreen extends StatelessWidget {
//   const PreHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //return Home or Auth

//     final user2 = Provider.of<UserModel?>(context);

//     return FutureBuilder<User>(
//             future: FirebaseAuth.instance.app(),
//             builder: (BuildContext context, AsyncSnapshot<User> snapshot){
//                        if (snapshot.hasData){
//                            User user = snapshot.data; // this is your user instance
//                            /// is because there is user already logged
//                            return MainScreen();
//                         }
//                          /// other way there is no user logged.
//                          return LoginScreen();
//              }
//           );
//   }
// }