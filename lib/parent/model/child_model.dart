class Child {
  String name;
  String age;
  String gender;
  String email;
  String Parentemail;
  int succes;
  int fail = 0;
  int TotalTry = 0;

  Child({
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
    required this.Parentemail,
    this.succes = 0,
    this.fail = 0,
    this.TotalTry = 0,
  });

  // make the mode --> map --> to be able to store it
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'email': email,
      'Parentemail': Parentemail,
      'succes': succes,
      'fail': fail,
      'TotalTry': TotalTry,
    };
  }

  // to return from the map to an model
  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] ?? '',
      email: map['email'] ?? '',
      Parentemail: map['Parentemail'] ?? '',
      succes: map['succes'] ?? 0,
      fail: map['fail'] ?? 0,
      TotalTry: map['TotalTry'] ?? 0,
    );
  }
}
