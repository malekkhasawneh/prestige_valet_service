class ParkedCarsModel {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  User user;
  User valet;
  String parkingStatus;
  bool washCar;

  ParkedCarsModel({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.user,
    required this.valet,
    required this.parkingStatus,
    required this.washCar,
  });

  factory ParkedCarsModel.fromJson(Map<String, dynamic> json) => ParkedCarsModel(
    createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        user: User.fromJson(json["user"]),
        valet: User.fromJson(json["valet"]),
        parkingStatus: json["parkingStatus"],
        washCar: json['carWash'],
      );

  Map<String, dynamic> toJson() =>
      {
        "createdOn": createdOn.toIso8601String(),
        "createdBy": createdBy,
        "updatedOn": updatedOn.toIso8601String(),
        "updatedBy": updatedBy,
        "id": id,
        "user": user.toJson(),
        "valet": valet.toJson(),
        "parkingStatus": parkingStatus,
        "carWash": washCar,
      };
}

class User {
  int id;
  String userUuid;
  String firstName;
  String lastName;
  String phone;
  String? profileImg;
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
    socialProfile: json["socialProfile"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
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
  String cityName;
  double price;
  String availabilityStatus;

  Location({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.locationName,
    required this.cityName,
    required this.price,
    required this.availabilityStatus,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    createdOn: DateTime.parse(json["createdOn"]),
    createdBy: json["createdBy"],
    updatedOn: DateTime.parse(json["updatedOn"]),
    updatedBy: json["updatedBy"],
    id: json["id"],
    locationName: json["locationName"],
    cityName: json["cityName"],
    price: json["price"],
    availabilityStatus: json["availabilityStatus"],
  );

  Map<String, dynamic> toJson() => {
    "createdOn": createdOn.toIso8601String(),
    "createdBy": createdBy,
    "updatedOn": updatedOn.toIso8601String(),
    "updatedBy": updatedBy,
    "id": id,
    "locationName": locationName,
    "cityName": cityName,
    "price": price,
    "availabilityStatus": availabilityStatus,
  };
}
