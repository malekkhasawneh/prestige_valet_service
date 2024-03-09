class RetrieveCarModel {
  int id;
  int locationId;
  User? user;
  User? valet;
  int retrieveAtGate;
  bool isGuest;
  String guestName;
  String parkingStatus;
  double parkingPrice;
  double totalPrice;
  int gateId;

  RetrieveCarModel({
    required this.id,
    required this.locationId,
    required this.user,
    required this.valet,
    required this.retrieveAtGate,
    required this.isGuest,
    required this.guestName,
    required this.parkingStatus,
    required this.parkingPrice,
    required this.totalPrice,
    this.gateId = -1,
  });

  factory RetrieveCarModel.fromJson(Map<String, dynamic> json) => RetrieveCarModel(
        id: json["id"] ?? 0,
        locationId: json["locationId"] ?? 0,
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        valet: json["valet"] == null ? null : User.fromJson(json["valet"]),
        retrieveAtGate: json["retrieveAtGate"] ?? 0,
        isGuest: json["isGuest"] ?? false,
        guestName: json["guestName"] ?? '',
        parkingStatus: json["parkingStatus"] ?? '',
        parkingPrice: json["parkingPrice"] == null
            ? 0.0
            : json["parkingPrice"].toDouble() ?? 0.0,
        totalPrice:
            json["totalPrice"] == null ? 0.0 : json["totalPrice"].toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "locationId": locationId,
        "user": user!.toJson(),
        "valet": valet!.toJson(),
        "retrieveAtGate": retrieveAtGate,
        "isGuest": isGuest,
        "guestName": guestName,
        "parkingStatus": parkingStatus,
        "parkingPrice": parkingPrice,
        "totalPrice": totalPrice,
      };
}

class User {
  int id;
  String userUuid;
  String firstName;
  String lastName;
  String phone;
  String? profileImg;
  bool active;
  bool socialProfile;
  Location? location;
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
    required this.role,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        userUuid: json["userUuid"] ?? '',
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        phone: json["phone"] ?? '',
        profileImg: json["profileImg"] ?? '',
        active: json["active"] ?? false,
        socialProfile: json["socialProfile"] ?? false,
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        role: json["role"] ?? '',
        email: json["email"] ?? '',
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
        "location": location?.toJson(),
        "role": role,
        "email": email,
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
  Currency? currency;
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
        createdOn:
            DateTime.parse(json["createdOn"] ?? DateTime.now().toString()),
        createdBy: json["createdBy"] ?? '',
        updatedOn:
            DateTime.parse(json["updatedOn"] ?? DateTime.now().toString()),
        updatedBy: json["updatedBy"] ?? '',
        id: json["id"] ?? 0,
        locationName: json["locationName"] ?? '',
        price: json["price"] == null ? 0.0 : json["price"].toDouble() ?? 0.0,
        currency: json["currency"] == null
            ? null
            : Currency.fromJson(json["currency"]),
        countryId: json["countryId"] ?? 0,
        availabilityStatus: json["availabilityStatus"] ?? '',
      );

  Map<String, dynamic> toJson() =>
      {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "locationName": locationName,
        "price": price,
        "currency": currency!.toJson(),
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
  Country? country;

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
        createdOn:
            DateTime.parse(json["createdOn"] ?? DateTime.now().toString()),
        createdBy: json["createdBy"] ?? '',
        updatedOn:
            DateTime.parse(json["updatedOn"] ?? DateTime.now().toString()),
        updatedBy: json["updatedBy"] ?? '',
        id: json["id"] ?? 0,
        currencySymbol: json["currencySymbol"] ?? '',
        currencyName: json["currencyName"] ?? '',
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "currencySymbol": currencySymbol,
        "currencyName": currencyName,
        "country": country!.toJson(),
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
        createdOn:
            DateTime.parse(json["createdOn"] ?? DateTime.now().toString()),
        createdBy: json["createdBy"] ?? '',
        updatedOn:
            DateTime.parse(json["updatedOn"] ?? DateTime.now().toString()),
        updatedBy: json["updatedBy"] ?? '',
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
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
