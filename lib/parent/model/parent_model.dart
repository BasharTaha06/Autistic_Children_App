class Parent {
  String name;
  String phone;
  String email;

  Parent({
    required this.name,
    required this.phone,
    required this.email,
  });

  // make the mode --> map --> to be able to store it
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  // to return from the map to an model
  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
