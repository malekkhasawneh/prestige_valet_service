class RetrieveCarModel {
  int id;
  int locationId;
  int userId;
  int valetId;
  int retrieveAtGate;
  bool isGuest;
  String guestName;
  String parkingStatus;
  bool carWash;
  int carWashPrice;
  int parkingPrice;
  int totalPrice;

  RetrieveCarModel({
    required this.id,
    required this.locationId,
    required this.userId,
    required this.valetId,
    required this.retrieveAtGate,
    required this.isGuest,
    required this.guestName,
    required this.parkingStatus,
    required this.carWash,
    required this.carWashPrice,
    required this.parkingPrice,
    required this.totalPrice,
  });

  factory RetrieveCarModel.fromJson(Map<String, dynamic> json) => RetrieveCarModel(
    id: json["id"],
    locationId: json["locationId"],
    userId: json["userId"],
    valetId: json["valetId"],
    retrieveAtGate: json["retrieveAtGate"],
    isGuest: json["isGuest"],
    guestName: json["guestName"] ?? '',
    parkingStatus: json["parkingStatus"],
    carWash: json["carWash"],
    carWashPrice: json["carWashPrice"],
    parkingPrice: json["parkingPrice"],
    totalPrice: json["totalPrice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "locationId": locationId,
    "userId": userId,
    "valetId": valetId,
    "retrieveAtGate": retrieveAtGate,
    "isGuest": isGuest,
    "guestName": guestName,
    "parkingStatus": parkingStatus,
    "carWash": carWash,
    "carWashPrice": carWashPrice,
    "parkingPrice": parkingPrice,
    "totalPrice": totalPrice,
  };
}
