// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:flutter_sports_app/Shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  //final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth1 = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

//text field states
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[900],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 10.0,
              title: const Text('Sign In to Team'),
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(Icons.person),
                    label: Text(
                      'Not a member? Register',
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.purple,
                      iconColor: Colors.green, // Text Color
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/playerReg');
                    }),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/football.jpg'),
              //     fit: BoxFit.fill,
              //   ),
              // ),
              child: Form(
                  key: _formKey,
                  //Wrapping Column with SingleChildScrollView removes glitch
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        //Image.asset('assets/coffee_icon.png'),
                        Icon(
                          Icons.sports_soccer,
                          size: 200,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Futsal App',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.yellow[400],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //intro
                        Text(
                          'Hello, please sign IN below',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: formBoxDecor,
                          child: TextFormField(
                            decoration: textInputDecor.copyWith(
                                hintText: 'Enter email'),
                            validator: (val3) =>
                                val3!.isEmpty ? "Enter an email" : null,
                            onChanged: (val1) {
                              setState(() => email = val1);
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'Enter pass'),
                          obscureText: true,
                          validator: (val4) => val4!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                          onChanged: (val2) {
                            setState(() => password = val2);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                            child: Text('Sign In'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth1.signInWithEmailAndPassword(
                                        email, password);

                                if (result == null) {
                                  setState(() {
                                    error =
                                        'COULD NOT SIGN INNNNN with THOSE CREDZ';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  )),
            ),
          );
  }
}
