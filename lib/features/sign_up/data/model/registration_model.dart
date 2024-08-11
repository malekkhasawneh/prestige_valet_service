class SignUpModel {
  String token;
  String message;
  User user;
  int statusCode;

  SignUpModel({
    required this.token,
    required this.message,
    required this.user,
    required this.statusCode,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        token: json["token"] ?? '',
        message: json["message"] ?? '',
        statusCode: int.tryParse(json["message"]) ?? -1,
        user: User.fromJson(json["user"] ??
            User(
                id: -1,
                userId: '',
                firstName: '',
                lastName: '',
                phone: '',
                profileImg: '',
                socialProfile: false,
                role: '',
                    email: '',
                    gate: null)
                .toJson()),
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
  Gate? gate;
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
    required this.gate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? -1,
        userId: json["userUuid"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        phone: json["phone"] ?? '',
        profileImg: json["profileImg"] ?? '',
        socialProfile: json["socialProfile"] ?? false,
        role: json["role"] ?? '',
        email: json["email"] ?? '',
        gate: json["gate"] == null ? null : Gate.fromJson(json["gate"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userUuid": userId,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "profileImg": profileImg,
    "socialProfile": socialProfile,
    "role": role,
    "email": email,
        "gate": gate?.toJson(),
      };
}

class Gate {
  int id;

  Gate({
    required this.id,
  });

  factory Gate.fromJson(Map<String, dynamic> json) => Gate(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
