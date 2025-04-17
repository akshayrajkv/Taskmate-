class Usermodel {
  final String name;
  final String email;

  Usermodel({required this.name, required this.email});

  // Factory constructor to create User from JSON
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      name: json['name'],
      email: json['email'],
    );
  }
}