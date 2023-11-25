class RegistrationModel {
  String token;
  String message;
  User user;

  RegistrationModel({
    required this.token,
    required this.message,
    required this.user,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    token: json["token"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  int id;
  String userId;
  String firstName;
  String lastName;
  String phone;
  String profileImg;
  bool socialProfile;
  String role;
  String email;

  User({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImg,
    required this.socialProfile,
    required this.role,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    profileImg: json["profileImg"],
    socialProfile: json["socialProfile"],
    role: json["role"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "profileImg": profileImg,
    "socialProfile": socialProfile,
    "role": role,
    "email": email,
  };
}
