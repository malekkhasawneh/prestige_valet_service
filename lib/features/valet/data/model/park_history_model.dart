class ParkHistoryModel {
  List<ParkHistoryContent> content;

  ParkHistoryModel({
    required this.content,
  });

  factory ParkHistoryModel.fromJson(Map<String, dynamic> json) =>
      ParkHistoryModel(
        content: List<ParkHistoryContent>.from(
            json["content"].map((x) => ParkHistoryContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class ParkHistoryContent {
  Parking parking;
  DateTime? deliveredDate;
  DateTime parkingDate;
  double? price;
  String? paymentMethod;

  ParkHistoryContent({
    required this.parking,
    required this.deliveredDate,
    required this.parkingDate,
    required this.price,
    required this.paymentMethod,
  });

  factory ParkHistoryContent.fromJson(Map<String, dynamic> json) =>
      ParkHistoryContent(
        parking: Parking.fromJson(json["parking"]),
        deliveredDate: json["deliveredDate"] == null
            ? null
            : DateTime.parse(json["deliveredDate"]),
        parkingDate: DateTime.parse(json["parkingDate"]),
        price: json["price"],
        paymentMethod: json["paymentMethod"],
      );

  Map<String, dynamic> toJson() => {
        "parking": parking.toJson(),
        "deliveredDate": deliveredDate?.toIso8601String(),
        "parkingDate": parkingDate.toIso8601String(),
        "price": price,
        "paymentMethod": paymentMethod,
      };
}

class Parking {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  User? user;
  User valet;
  dynamic retrieveAtGate;
  bool isGuest;
  dynamic guestName;
  String parkingStatus;

  Parking({
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
    required this.parkingStatus,
  });

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        valet: User.fromJson(json["valet"]),
        retrieveAtGate: json["retrieveAtGate"],
        isGuest: json["isGuest"],
        guestName: json["guestName"],
        parkingStatus: json["parkingStatus"],
      );

  Map<String, dynamic> toJson() => {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "user": user!.toJson(),
        "valet": valet.toJson(),
        "retrieveAtGate": retrieveAtGate,
        "isGuest": isGuest,
        "guestName": guestName,
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
        id: json["id"],
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

class Pageable {
  int pageNumber;
  int pageSize;
  Sort sort;
  int offset;
  bool paged;
  bool unpaged;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.paged,
    required this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        sort: Sort.fromJson(json["sort"]),
        offset: json["offset"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "sort": sort.toJson(),
        "offset": offset,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  bool empty;
  bool sorted;
  bool unsorted;

  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}
