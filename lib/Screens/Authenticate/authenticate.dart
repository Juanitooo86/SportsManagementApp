import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Screens/Authenticate/register.dart';
import 'package:flutter_sports_app/Screens/Authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // bool showSignIn = true;
  // bool showTeamReg = false;

  // void toggleView() {
  //   setState(() => showSignIn = !showSignIn);
  // }

  @override
  Widget build(BuildContext context) {
    // if (showSignIn) {
    //   return SignIn(toggleView: toggleView);
    // } else {
    //   return Register(toggleView: toggleView);
    // }
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SignIn(),
        '/playerReg': (context) => Register(),
        //'/teamReg': (context) => TeamRegister(),
      },
    );
  }
}
