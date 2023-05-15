// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Services/auth.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:flutter_sports_app/Shared/loading.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);

  //final Function toggleView;
  //Register({required this.toggleview});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth1 = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

//text field states
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  int age = 0;
  String firstName = '';
  String lastName = '';
  String teamId = '';
  String role = 'player';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[900],
            appBar: AppBar(
              backgroundColor: Colors.amber[400],
              elevation: 10.0,
              title: const Text('Sign Up to Team'),
              actions: <Widget>[
                TextButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Need to sign in?'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    }),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        Text(
                          'Futsal App',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.blue[900],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //intro
                        Text(
                          'Hello, please sign UP below',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        //enter first name
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'First Name'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter a first name" : null,
                          onChanged: (val1) {
                            setState(() => firstName = val1);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //enter last name
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'Last Name'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter a last name" : null,
                          onChanged: (val1) {
                            setState(() => lastName = val1);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //enter age
                        TextFormField(
                          decoration: textInputDecor.copyWith(hintText: 'Age'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter an Age" : null,
                          onChanged: (val1) {
                            setState(() => age = int.parse(val1));
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //enter email
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'Enter email'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter an email" : null,
                          onChanged: (val1) {
                            setState(() => email = val1);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        // create password
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'Create pass'),
                          obscureText: true,
                          validator: (val4) => val4!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                          onChanged: (val2) {
                            setState(() => password = val2);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        //confirm pass
                        TextFormField(
                          decoration:
                              textInputDecor.copyWith(hintText: 'Confirm pass'),
                          obscureText: true,
                          validator: (val4) => val4!.length < 6
                              ? "Enter a password 6+ chars long"
                              : null,
                          onChanged: (val22) {
                            setState(() => confirmPassword = val22);
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                            child: Text('Register'),
                            onPressed: () async {
                              if (password == confirmPassword) {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth1.registerWithEmailAndPassword(
                                          email,
                                          password,
                                          firstName,
                                          lastName,
                                          age,
                                          teamId,
                                          role);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Please supply a valid email!?!';
                                      loading = false;
                                    });
                                  }
                                }
                              } else {
                                setState(() {
                                  error = 'Passwords does not match!!!';
                                  loading = false;
                                });
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
