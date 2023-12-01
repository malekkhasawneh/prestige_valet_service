class EditCardModel {
  final int id;
  final String message;

  EditCardModel({required this.id, required this.message});

  factory EditCardModel.fromJson(Map<String, dynamic> json) {
    return EditCardModel(
      id: json['id'],
      message: json['message'],
    );
  }
}
