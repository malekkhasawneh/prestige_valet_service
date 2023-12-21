class ParkHistoryModel {
  List<ParkHistoryContent> content;

  ParkHistoryModel({
    required this.content,
  });

  factory ParkHistoryModel.fromJson(Map<String, dynamic> json) =>
      ParkHistoryModel(
        content:
            List<ParkHistoryContent>.from(json["content"].map((x) => ParkHistoryContent.fromJson(x))),
      );
}

class ParkHistoryContent {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  ParkHistoryContentUser? user;
  ParkHistoryContentUser valet;
  String parkingStatus;
  bool? carWash;
bool isGuest;
String guestName;
  ParkHistoryContent({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.user,
    required this.valet,
    required this.parkingStatus,
    required this.carWash,
    required this.isGuest,
    required this.guestName,
  });

  factory ParkHistoryContent.fromJson(Map<String, dynamic> json) => ParkHistoryContent(
    createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"] ?? '',
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"] ?? '',
        id: json["id"],
        user: json["user"] == null
            ? null
            : ParkHistoryContentUser.fromJson(json["user"]),
        valet: ParkHistoryContentUser.fromJson(json["valet"]),
        parkingStatus: json["parkingStatus"] ?? '',
        carWash: json["carWash"] ?? false,
    isGuest: json["isGuest"] ?? false,
    guestName: json["guestName"] ?? '',
      );
}

class ParkHistoryContentUser {
  int id;
  String userUuid;
  String firstName;
  String lastName;
  String phone;
  String profileImg;
  bool socialProfile;
  Location? location;
  String role;
  String email;

  ParkHistoryContentUser({
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

  factory ParkHistoryContentUser.fromJson(Map<String, dynamic> json) => ParkHistoryContentUser(
        id: json["id"],
        userUuid: json["userUuid"]??'',
        firstName: json["firstName"]??'',
        lastName: json["lastName"]??'',
        phone: json["phone"]??'',
        profileImg: json["profileImg"]??'',
        socialProfile: json["socialProfile"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        role: json["role"]??'',
        email: json["email"]??'',
      );
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
        createdBy: json["createdBy"]??'',
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"]??'',
        id: json["id"],
        locationName: json["locationName"]??'',
        cityName: json["cityName"]??'',
        price: json["price"],
        availabilityStatus: json["availabilityStatus"]??'',
      );
}
