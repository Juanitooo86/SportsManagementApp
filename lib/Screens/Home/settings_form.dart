//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  // final List<String> lastnames = [
  //   'Williams',
  //   'Krumos',
  //   'Ilpitya',
  //   'Nakamura',
  //   'Statham'
  // ];

  String? _currentFirstName;
  String? _currentLastName;
  int? _currentAge = 0;
  // final String _currentTeamName = 'Bronto';
  // final String _currentTeamRole = 'Player';
  //bool strFlag = true;

  @override
  Widget build(BuildContext context) {
    final user2 = Provider.of<UserModel?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user2?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                // ignore: prefer_const_constructors

                Text(
                  'Update ur player settingZ',
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 18.0, color: Colors.amber),
                ),
                const SizedBox(height: 20.0),
                //firstName
                TextFormField(
                  initialValue: userData?.firstName,
                  decoration: textInputDecor,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a first name' : null,
                  onChanged: (val) => setState(() => _currentFirstName = val),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //lastName
                TextFormField(
                  initialValue: userData?.lastName,
                  decoration: textInputDecor,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a last name' : null,
                  onChanged: (val) => setState(() => _currentLastName = val),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //dropdown lastname
                // DropdownButtonFormField<String>(
                //   decoration: textInputDecor,
                //   value: userData?.lastName,
                //   items: lastnames.map((lastName1) {
                //     return DropdownMenuItem(
                //         value: lastName1, child: Text('$lastName1 Mr'));
                //   }).toList(),
                //   onChanged: (valu) => setState(() => _currentLastName = valu!),
                // ),
                //age update
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  initialValue: userData?.age.toString(),
                  decoration: textInputDecor,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter an age' : null,
                  onChanged: (val) =>
                      setState(() => _currentAge = int.tryParse(val)),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //slider
                // Slider(
                //   value: (_currentAge ?? userData?.age as int).toDouble(),
                //   activeColor: Colors.blue[_currentAge ?? userData?.age as int],
                //   min: 10,
                //   max: 90,
                //   divisions: 8,
                //   onChanged: (val23) =>
                //       setState(() => _currentAge = val23.round()),
                // ),
                ElevatedButton(
                  child: const Text(
                    'Udpate',
                    style: TextStyle(color: Colors.yellow),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user2?.uid)
                          .updateUserDataInSettingz(
                              _currentFirstName ?? userData?.firstName,
                              _currentLastName ?? userData?.lastName,
                              _currentAge ?? userData?.age as int
                              //_currentTeamName,
                              //_currentTeamRole
                              );
                      Navigator.pop(context);
                    }
                  },
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
