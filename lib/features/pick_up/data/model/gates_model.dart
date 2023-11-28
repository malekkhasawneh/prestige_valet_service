class GatesModel {
  List<Gates> gates;

  GatesModel({
    required this.gates,
  });

  factory GatesModel.fromJson(Map<String, dynamic> json) =>
      GatesModel(
        gates: List<Gates>.from(json["content"].map((x) => Gates.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "content": List<dynamic>.from(gates.map((x) => x.toJson())),
      };
}

class Gates {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String name;
  String description;
  String mallName;
  bool isSelected;

  Gates({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.name,
    required this.description,
    required this.mallName,
    this.isSelected = false,
  });

  factory Gates.fromJson(Map<String, dynamic> json) =>
      Gates(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        mallName: json["mallName"],
      );

  Map<String, dynamic> toJson() =>
      {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "name": name,
        "description": description,
        "mallName": mallName,
      };
}
