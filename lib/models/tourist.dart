class Tourist {
  final String firstName;
  final String lastName;
  final String citizenship;
  final String passportId;
  final DateTime passportExpire;

  Tourist({
    required this.firstName,
    required this.lastName,
    required this.citizenship,
    required this.passportId,
    required this.passportExpire,
  });

  static Tourist empty() {
    return Tourist(
      firstName: '',
      lastName: '',
      citizenship: '',
      passportId: '',
      passportExpire: DateTime.now(),
    );
  }
}
