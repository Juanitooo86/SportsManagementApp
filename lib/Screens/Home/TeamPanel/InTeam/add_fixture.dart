import 'package:flutter/material.dart';
import 'package:flutter_sports_app/Models/user_model.dart';
import 'package:flutter_sports_app/Screens/Home/TeamPanel/InTeam/fixtures_list.dart';
import 'package:flutter_sports_app/Services/database.dart';
import 'package:flutter_sports_app/Shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sports_app/Shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFixture extends StatefulWidget {
  const AddFixture({super.key});

  @override
  State<AddFixture> createState() => _AddFixtureState();
}

class _AddFixtureState extends State<AddFixture> {
  TextEditingController _opponentNameController = TextEditingController();
  TextEditingController _placePostCodeController = TextEditingController();
  DateTime selectedTimeDate = DateTime.now();
  DateTime dateTime = DateTime(2023, 01, 01, 12, 00);

  void _backToFixtureList(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => FixturesList()),
      (route) => false,
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return; // pressed cancel

    TimeOfDay? time = await pickTime();
    if (time == null) return; // pressed cancel

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => this.dateTime = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

  @override
  Widget build(BuildContext context) {
    final user3 = FirebaseAuth.instance.currentUser!;
    final userForJoin = Provider.of<UserModel?>(context);
    final vremya = Timestamp.fromDate(dateTime);
    //TimeOfDay time = TimeOfDay(hour: 12, minute: 00);
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: userForJoin?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData3 = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Scaffold(
                appBar: AppBar(
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        color: Colors.blue,
                        onPressed: () => _backToFixtureList(context)),
                    backgroundColor: Colors.green[400],
                    elevation: 10.0,
                    title: Text(userData3!.firstName!), //current user logged in
                    actions: <Widget>[
                      // TextButton.icon(
                      //     icon: Icon(Icons.logout),
                      //     label: Text('Logout'),
                      //     onPressed: () async {
                      //       //await _auth.signOUtZ();
                      //     }),
                      // TextButton.icon(
                      //   icon: Icon(Icons.settings),
                      //   label: Text('Settings'),
                      //   onPressed: () async {},
                      // )
                    ]),
                body: SizedBox.expand(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 50.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/football.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Form(
                      child: SingleChildScrollView(
                          child: Column(children: <Widget>[
                        Icon(
                          Icons.sports_soccer,
                          size: 200,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'Add a Fixture',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                            color: Colors.amber[400],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // ignore: prefer_const_constructors
                        Text(
                          'Provide details below',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          //opponent team name input
                          controller: _opponentNameController,
                          decoration: textInputDecor.copyWith(
                              prefixIcon: Icon(Icons.text_format),
                              hintText: 'Enter Opponent Name'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter Opp Name" : null,
                          onChanged: (val1) {},
                        ),
                        const SizedBox(height: 20.0),

                        TextFormField(
                          //fixture place input
                          controller: _placePostCodeController,
                          decoration: textInputDecor.copyWith(
                              prefixIcon: Icon(Icons.place),
                              hintText: 'Enter Place Post Code'),
                          validator: (val3) =>
                              val3!.isEmpty ? "Enter Post Code" : null,
                          onChanged: (val1) {},
                        ),
                        const SizedBox(height: 20.0),

                        Text(
                          'Choose Date & Time below',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                            onPressed: pickDateTime,
                            //  () async {
                            // showTimePicker(
                            //     context: context, initialTime: time);
                            //},
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue,
                            ),
                            child: Text(
                                '${dateTime.year}/${dateTime.month}/${dateTime.day} $hours:$minutes')),

                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            _backToFixtureList(context);
                            await DatabaseService(uid: userForJoin?.uid)
                                .addFixtureToTeam(
                                    userData3.teamId,
                                    _opponentNameController.text,
                                    _placePostCodeController.text,
                                    vremya);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.brown,
                            backgroundColor: Colors.yellow,
                          ),
                          child: Text('Create Fixture'),
                        ),
                      ])),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
