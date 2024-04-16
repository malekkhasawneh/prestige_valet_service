class ValetHistoryModel {
  List<Content> content;

  ValetHistoryModel({
    required this.content,
  });

  factory ValetHistoryModel.fromJson(Map<String, dynamic> json) => ValetHistoryModel(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),

  );

}

class Content {
  int id;
  Valet? user;
  Valet valet;
  RetrieveAtGate? retrieveAtGate;
  bool isGuest;
  String? guestName;
  int slotNumber;
  String parkingStatus;

  Content({
    required this.id,
    required this.user,
    required this.valet,
    required this.retrieveAtGate,
    required this.isGuest,
    required this.guestName,
    required this.slotNumber,
    required this.parkingStatus,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    user: json["user"] == null ? null : Valet.fromJson(json["user"]),
    valet: Valet.fromJson(json["valet"]),
    retrieveAtGate: json["retrieveAtGate"] == null ? null : RetrieveAtGate.fromJson(json["retrieveAtGate"]),
    isGuest: json["isGuest"],
    guestName: json["guestName"] ?? '',
        slotNumber: json['slotNumber'] ?? 0,
        parkingStatus: json["parkingStatus"] ?? '',
      );
}


class RetrieveAtGate {
  int id;
  String? gateName;
  String description;
  double price;
  int countryId;
  String status;

  RetrieveAtGate({
    required this.id,
    required this.gateName,
    required this.description,
    required this.price,
    required this.countryId,
    required this.status,
  });

  factory RetrieveAtGate.fromJson(Map<String, dynamic> json) => RetrieveAtGate(
    id: json["id"],
    gateName: json["gateName"] ?? '',
    description: json["description"],
    price: json["price"],
    countryId: json["countryId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gateName": gateName,
    "description": description,
    "price": price,
    "countryId": countryId,
  };
}

class Valet {
  int id;
  String userUuid;
  String? firstName;
  String? lastName;
  String? phone;
  String? profileImg;
  bool active;
  bool socialProfile;
  Location? location;
  String? role;
  String? email;

  Valet({
    required this.id,
    required this.userUuid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImg,
    required this.active,
    required this.socialProfile,
    required this.location,
    required this.role,
    required this.email,
  });

  factory Valet.fromJson(Map<String, dynamic> json) => Valet(
    id: json["id"],
    userUuid: json["userUuid"],
    firstName: json["firstName"]??'',
    lastName: json["lastName"]??'',
    phone: json["phone"] ?? '',
    profileImg: json["profileImg"] ?? '',
    active: json["active"],
    socialProfile: json["socialProfile"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    role: json["role"]??'',
    email: json["email"]??'',
  );
}
class Location {
  int id;
  String locationName;
  double price;

  Location({
    required this.id,
    required this.locationName,
    required this.price,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    locationName: json["locationName"],
    price: json["price"],
  );

}


class Country {
  String name;

  Country({
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
  );

}

