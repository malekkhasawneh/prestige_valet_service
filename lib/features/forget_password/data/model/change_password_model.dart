class ChangePasswordModel {
  final String message;
  final int statusCode;

  ChangePasswordModel({required this.message, required this.statusCode});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json){
    return ChangePasswordModel(
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}