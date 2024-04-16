class RetrieveCarQueueModel {
  List<Content> content;

  RetrieveCarQueueModel({
    required this.content,
  });

  factory RetrieveCarQueueModel.fromJson(Map<String, dynamic> json) =>
      RetrieveCarQueueModel(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  User user;
  User valet;
  dynamic retrieveAtGate;
  bool isGuest;
  String guestName;
  int slotNumber;
  String parkingStatus;

  Content({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
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
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        user: User.fromJson(json["user"]),
        valet: User.fromJson(json["valet"]),
        retrieveAtGate: json["retrieveAtGate"],
        isGuest: json["isGuest"],
        guestName: json["guestName"],
        slotNumber: json["slotNumber"],
        parkingStatus: json["parkingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "user": user.toJson(),
        "valet": valet.toJson(),
        "retrieveAtGate": retrieveAtGate,
        "isGuest": isGuest,
        "guestName": guestName,
        "slotNumber": slotNumber,
        "parkingStatus": parkingStatus,
      };
}

class User {
  int id;
  String userUuid;
  String firstName;
  String lastName;
  String phone;
  String profileImg;
  bool active;
  bool socialProfile;
  Location location;
  Gate gate;
  String role;
  String email;

  User({
    required this.id,
    required this.userUuid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImg,
    required this.active,
    required this.socialProfile,
    required this.location,
    required this.gate,
    required this.role,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userUuid: json["userUuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        profileImg: json["profileImg"],
        active: json["active"],
        socialProfile: json["socialProfile"],
        location: Location.fromJson(json["location"]),
        gate: Gate.fromJson(json["gate"]),
        role: json["role"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userUuid": userUuid,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "profileImg": profileImg,
        "active": active,
        "socialProfile": socialProfile,
        "location": location.toJson(),
        "gate": gate.toJson(),
        "role": role,
        "email": email,
      };
}

class Gate {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String gateName;
  String description;
  double price;
  int currentSlot;
  int countryId;
  String status;

  Gate({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.gateName,
    required this.description,
    required this.price,
    required this.currentSlot,
    required this.countryId,
    required this.status,
  });

  factory Gate.fromJson(Map<String, dynamic> json) => Gate(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        gateName: json["gateName"],
        description: json["description"],
        price: json["price"],
        currentSlot: json["currentSlot"],
        countryId: json["countryId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "gateName": gateName,
        "description": description,
        "price": price,
        "currentSlot": currentSlot,
        "countryId": countryId,
        "status": status,
      };
}

class Location {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String locationName;
  double price;
  Currency currency;
  int countryId;
  String availabilityStatus;

  Location({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.locationName,
    required this.price,
    required this.currency,
    required this.countryId,
    required this.availabilityStatus,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        locationName: json["locationName"],
        price: json["price"],
        currency: Currency.fromJson(json["currency"]),
        countryId: json["countryId"],
        availabilityStatus: json["availabilityStatus"],
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "locationName": locationName,
        "price": price,
        "currency": currency.toJson(),
        "countryId": countryId,
        "availabilityStatus": availabilityStatus,
      };
}

class Currency {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String currencySymbol;
  String currencyName;
  Country country;

  Currency({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.currencySymbol,
    required this.currencyName,
    required this.country,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        currencySymbol: json["currencySymbol"],
        currencyName: json["currencyName"],
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "currencySymbol": currencySymbol,
        "currencyName": currencyName,
        "country": country.toJson(),
      };
}

class Country {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String name;
  String symbol;

  Country({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.name,
    required this.symbol,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "name": name,
        "symbol": symbol,
      };
}
