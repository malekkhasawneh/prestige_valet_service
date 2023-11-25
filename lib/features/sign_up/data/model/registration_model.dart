class RegistrationModel {
  final String token;
  final int id;
  final String message;
  final String role;
  final bool socialProfile;

  RegistrationModel(
      {required this.token,
      required this.id,
      required this.message,
      required this.role,
      required this.socialProfile});

  factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      token: json['token'],
      id: json['id'],
      message: json['message'],
      role: json['role'],
      socialProfile: json['socialProfile'],
    );
  }
}
