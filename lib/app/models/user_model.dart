class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String rePassword;
  final String birthdate;
  final String gender;
  final List<String> interests;
  final String profilePicture;
  final double latitude;
  final double longitude;
  final bool? status;
  final int? coins;
  final bool? verified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.birthdate,
    required this.gender,
    required this.interests,
    required this.profilePicture,
    required this.latitude,
    required this.longitude,
    this.status,
    this.coins,
    this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      rePassword: json['re_password'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      interests: List<String>.from(json['interests']),
      profilePicture: json['profilePicture'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'] ?? null,
      coins: json['coins'] ?? null,
      verified: json['verified'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      're_password': rePassword,
      'birthdate': birthdate,
      'gender': gender,
      'interests': interests,
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'coins': coins,
      'verified': verified,
    };
  }
}
