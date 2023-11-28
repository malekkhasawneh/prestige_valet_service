class AddCardModel {
  final String id;
  final String message;

  AddCardModel({required this.id, required this.message});

  factory AddCardModel.fromJson(Map<String, dynamic> json) {
    return AddCardModel(
      id: json['id'],
      message: json['message'],
    );
  }
}
