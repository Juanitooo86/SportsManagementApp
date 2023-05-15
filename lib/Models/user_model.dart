class UserModel {
  final String? uid;
  final String? teamId;
  final String? firstName;

  UserModel({this.uid, this.teamId, this.firstName});
}

class UserData {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final int? age;
  final String? role;
  final String? teamId;

  UserData(
      {this.uid,
      this.firstName,
      this.lastName,
      this.age,
      this.role,
      this.teamId});
}
