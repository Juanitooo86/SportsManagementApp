class TeamModel {
  String? teamId;
  String? teamName;
  String? teamManager;
  List<String> teamPlayers;

  TeamModel(
      {this.teamId,
      this.teamName,
      this.teamManager,
      required this.teamPlayers});
}
