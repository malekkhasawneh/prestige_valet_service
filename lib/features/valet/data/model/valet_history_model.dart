class ValetHistoryModel {
  List<Content> content;

  ValetHistoryModel({
    required this.content,
  });

  factory ValetHistoryModel.fromJson(Map<String, dynamic> json) => ValetHistoryModel(
    content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  DateTime createdOn;
  CreatedBy createdBy;
  DateTime updatedOn;
  CreatedBy updatedBy;
  int id;
  Valet? user;
  Valet valet;
  RetrieveAtGate? retrieveAtGate;
  bool isGuest;
  String? guestName;
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
    required this.parkingStatus,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    createdOn: DateTime.parse(json["createdOn"]),
    createdBy: createdByValues.map[json["createdBy"]]!,
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: createdByValues.map[json["updatedBy"]]!,
    id: json["id"],
    user: json["user"] == null ? null : Valet.fromJson(json["user"]),
    valet: Valet.fromJson(json["valet"]),
    retrieveAtGate: json["retrieveAtGate"] == null ? null : RetrieveAtGate.fromJson(json["retrieveAtGate"]),
    isGuest: json["isGuest"],
    guestName: json["guestName"]??'',
    parkingStatus:json["parkingStatus"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": createdByValues.reverse[createdBy],
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": createdByValues.reverse[updatedBy],
    "id": id,
    "user": user?.toJson(),
    "valet": valet.toJson(),
    "retrieveAtGate": retrieveAtGate?.toJson(),
    "isGuest": isGuest,
    "guestName": guestName,
  };
}

enum CreatedBy {
  FARISASFOUR_GMAIL_COM,
  FARISASFOUR_ICLOUD_COM,
  MALEKKHASAWNEH43_GMAIL_COM,
  MALEKMAMOON341_GMAIL_COM,
  VALET1_PRESTIGE_COM
}

final createdByValues = EnumValues({
  "farisasfour@gmail.com": CreatedBy.FARISASFOUR_GMAIL_COM,
  "farisasfour@icloud.com": CreatedBy.FARISASFOUR_ICLOUD_COM,
  "malekkhasawneh43@gmail.com": CreatedBy.MALEKKHASAWNEH43_GMAIL_COM,
  "malekmamoon341@gmail.com": CreatedBy.MALEKMAMOON341_GMAIL_COM,
  "valet1@prestige.com": CreatedBy.VALET1_PRESTIGE_COM
});

class RetrieveAtGate {
  DateTime createdOn;
  AtedBy createdBy;
  DateTime updatedOn;
  AtedBy updatedBy;
  int id;
  String gateName;
  String description;
  double price;
  int countryId;
  Status status;

  RetrieveAtGate({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.gateName,
    required this.description,
    required this.price,
    required this.countryId,
    required this.status,
  });

  factory RetrieveAtGate.fromJson(Map<String, dynamic> json) => RetrieveAtGate(
    createdOn: DateTime.parse(json["createdOn"]),
    createdBy: atedByValues.map[json["createdBy"]]!,
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: atedByValues.map[json["updatedBy"]]!,
    id: json["id"],
    gateName: json["gateName"]??'',
    description: json["description"],
    price: json["price"],
    countryId: json["countryId"],
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": atedByValues.reverse[createdBy],
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": atedByValues.reverse[updatedBy],
    "id": id,
    "gateName": gateName,
    "description": description,
    "price": price,
    "countryId": countryId,
    "status": statusValues.reverse[status],
  };
}

enum AtedBy {
  SUPER_ADMIN_PRESTIGE_COM
}

final atedByValues = EnumValues({
  "superAdmin@prestige.com": AtedBy.SUPER_ADMIN_PRESTIGE_COM
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "ACTIVE": Status.ACTIVE
});

class Valet {
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
    profileImg: json["profileImg"],
    active: json["active"],
    socialProfile: json["socialProfile"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    role: json["role"]??'',
    email: json["email"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userUuid": userUuid,
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "profileImg": profileImg,
    "active": active,
    "socialProfile": socialProfile,
    "location": location?.toJson(),
    "role": roleValues.reverse[role],
    "email": createdByValues.reverse[email],
  };
}

enum FirstName {
  FARIS,
  MALEK,
  VALET
}

final firstNameValues = EnumValues({
  "faris": FirstName.FARIS,
  "Malek": FirstName.MALEK,
  "valet": FirstName.VALET
});

enum LastName {
  ASFOUR,
  KHADAWNEH,
  KHASAWNEH,
  VALET
}

final lastNameValues = EnumValues({
  "asfour": LastName.ASFOUR,
  "Khadawneh": LastName.KHADAWNEH,
  "Khasawneh ": LastName.KHASAWNEH,
  "valet": LastName.VALET
});

class Location {
  DateTime createdOn;
  AtedBy createdBy;
  DateTime updatedOn;
  AtedBy updatedBy;
  int id;
  LocationName locationName;
  double price;
  Currency currency;
  int countryId;
  Status availabilityStatus;

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
    createdBy: atedByValues.map[json["createdBy"]]!,
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: atedByValues.map[json["updatedBy"]]!,
    id: json["id"],
    locationName: locationNameValues.map[json["locationName"]]!,
    price: json["price"],
    currency: Currency.fromJson(json["currency"]),
    countryId: json["countryId"],
    availabilityStatus: statusValues.map[json["availabilityStatus"]]!,
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": atedByValues.reverse[createdBy],
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": atedByValues.reverse[updatedBy],
    "id": id,
    "locationName": locationNameValues.reverse[locationName],
    "price": price,
    "currency": currency.toJson(),
    "countryId": countryId,
    "availabilityStatus": statusValues.reverse[availabilityStatus],
  };
}

class Currency {
  DateTime createdOn;
  AtedBy createdBy;
  DateTime updatedOn;
  AtedBy updatedBy;
  int id;
  Symbol currencySymbol;
  CurrencyName currencyName;
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
    createdBy: atedByValues.map[json["createdBy"]]!,
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: atedByValues.map[json["updatedBy"]]!,
    id: json["id"],
    currencySymbol: symbolValues.map[json["currencySymbol"]]!,
    currencyName: currencyNameValues.map[json["currencyName"]]!,
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": atedByValues.reverse[createdBy],
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": atedByValues.reverse[updatedBy],
    "id": id,
    "currencySymbol": symbolValues.reverse[currencySymbol],
    "currencyName": currencyNameValues.reverse[currencyName],
    "country": country.toJson(),
  };
}

class Country {
  DateTime createdOn;
  AtedBy createdBy;
  DateTime updatedOn;
  AtedBy updatedBy;
  int id;
  Name name;
  Symbol symbol;

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
    createdBy: atedByValues.map[json["createdBy"]]!,
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: atedByValues.map[json["updatedBy"]]!,
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    symbol: symbolValues.map[json["symbol"]]!,
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": atedByValues.reverse[createdBy],
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": atedByValues.reverse[updatedBy],
    "id": id,
    "name": nameValues.reverse[name],
    "symbol": symbolValues.reverse[symbol],
  };
}

enum Name {
  EMPTY
}

final nameValues = EnumValues({
  "الأردن": Name.EMPTY
});

enum Symbol {
  JOD
}

final symbolValues = EnumValues({
  "JOD": Symbol.JOD
});

enum CurrencyName {
  EMPTY
}

final currencyNameValues = EnumValues({
  "دينار اردني": CurrencyName.EMPTY
});

enum LocationName {
  EMPTY
}

final locationNameValues = EnumValues({
  "تاج مول": LocationName.EMPTY
});

enum Role {
  USER,
  VALET
}

final roleValues = EnumValues({
  "USER": Role.USER,
  "VALET": Role.VALET
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
