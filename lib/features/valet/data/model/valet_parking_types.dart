class ValetParkingTypes {
  int id;
  String type;
  double price;
  bool isSelected;

  ValetParkingTypes({
    required this.id,
    required this.type,
    required this.price,
    this.isSelected = false,
  });

  factory ValetParkingTypes.fromJson(Map<String, dynamic> json) =>
      ValetParkingTypes(
        id: json["id"],
        type: json["type"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "price": price,
      };
}
