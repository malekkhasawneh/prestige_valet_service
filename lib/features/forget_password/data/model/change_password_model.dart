class ChangePasswordModel {
  final String message;
  final String id;

  ChangePasswordModel({required this.message, required this.id});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json){
    return ChangePasswordModel(
      message: json['message'],
      id: json['id'],
    );
  }
}