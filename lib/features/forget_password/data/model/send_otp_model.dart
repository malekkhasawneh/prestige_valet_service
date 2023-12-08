class SendOtpModel {
  final String id;
  final String message;

  SendOtpModel({required this.id, required this.message});

  factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(id: json['id'], message: json['message']);
  }
}
