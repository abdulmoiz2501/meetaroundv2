class UserLocationModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? birthdate;
  String? gender;
  List<String>? interests;
  String? profilePicture;
  double? latitude;
  double? longitude;
  bool? status;
  Null? coins;
  Null? verified;

  UserLocationModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.rePassword,
      this.birthdate,
      this.gender,
      this.interests,
      this.profilePicture,
      this.latitude,
      this.longitude,
      this.status,
      this.coins,
      this.verified});

  UserLocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    rePassword = json['re_password'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    interests = json['interests'].cast<String>();
    profilePicture = json['profilePicture'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    coins = json['coins'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['re_password'] = this.rePassword;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['interests'] = this.interests;
    data['profilePicture'] = this.profilePicture;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['coins'] = this.coins;
    data['verified'] = this.verified;
    return data;
  }
}
