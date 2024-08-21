class User {
  final int id;
  final String name;
  final String email;
  final String birthdate;
  final String gender;
  final List<String> interests;
  final String profilePicture;
  final double latitude;
  final double longitude;
  //final String address; // This will be calculated
  //final String distance; // This will be static for now
 
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.birthdate,
    required this.gender,
    required this.interests,
    required this.profilePicture,
    required this.latitude,
    required this.longitude,
    //required this.address,
   // required this.distance,
 
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      birthdate: json['birthdate'] ?? '',
      gender: json['gender'] ?? '',
      interests: List<String>.from(json['interests'] ?? []),
      profilePicture: json['profilePicture'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
     
      //address: '', // Will be calculated
     // distance: '2.5 km', // Static for now
    );
  }
}
