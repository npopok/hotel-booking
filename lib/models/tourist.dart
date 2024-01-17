class Tourist {
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String citizenship;
  String passportNumber;
  DateTime passportExpires;

  Tourist({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.citizenship,
    required this.passportNumber,
    required this.passportExpires,
  });

  static Tourist empty() {
    return Tourist(
      firstName: '',
      lastName: '',
      dateOfBirth: DateTime(0),
      citizenship: '',
      passportNumber: '',
      passportExpires: DateTime(0),
    );
  }
}
