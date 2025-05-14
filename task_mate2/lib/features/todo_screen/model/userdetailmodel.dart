class Usermodel {
  final String name;
  final String email;
  final String ?profileimage;

  Usermodel({required this.name, required this.email,this.profileimage});

  // Factory constructor to create User from JSON
  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      name: json['name'],
      email: json['email'],
      profileimage: json['profileImage']
    );
  }
}