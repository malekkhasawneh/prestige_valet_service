class RetrieveCarModel {
  double id;
  double locationId;
  User user;
  User valet;
  double retrieveAtGate;
  bool isGuest;
  String guestName;
  String parkingStatus;
  bool carWash;
  double carWashPrice;
  double parkingPrice;
  double totalPrice;

  RetrieveCarModel({
    required this.id,
    required this.locationId,
    required this.user,
    required this.valet,
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
    id: json["id"].toDouble(),
        locationId: json["locationId"].toDouble(),
        user: User.fromJson(json["user"]),
        valet: User.fromJson(json["valet"]),
        retrieveAtGate: json["retrieveAtGate"].toDouble(),
        isGuest: json["isGuest"],
        guestName: json["guestName"] ?? '',
        parkingStatus: json["parkingStatus"],
        carWash: json["carWash"],
        carWashPrice: json["carWashPrice"].toDouble(),
        parkingPrice: json["parkingPrice"].toDouble(),
        totalPrice: json["totalPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "locationId": locationId,
        "user": user.toJson(),
        "valet": valet.toJson(),
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

class User {
  double id;
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
        id: json["id"].toDouble(),
        userUuid: json["userUuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        profileImg: json["profileImg"],
        active: json["active"],
        socialProfile: json["socialProfile"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
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
  double id;
  String locationName;
  double price;
  Currency currency;
  double countryId;
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
        id: json["id"].toDouble(),
        locationName: json["locationName"],
        price: json["price"].toDouble(),
        currency: Currency.fromJson(json["currency"]),
        countryId: json["countryId"].toDouble(),
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
  double id;
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
        id: json["id"].toDouble(),
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
  double id;
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
        id: json["id"].toDouble(),
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
