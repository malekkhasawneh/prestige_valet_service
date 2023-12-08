class GatesModel {
  List<GatesContent> content;

  GatesModel({
    required this.content,
  });

  factory GatesModel.fromJson(Map<String, dynamic> json) => GatesModel(
        content: List<GatesContent>.from(
            json["content"].map((x) => GatesContent.fromJson(x))),
      );
}

class GatesContent {
  DateTime createdOn;
  String createdBy;
  DateTime updatedOn;
  String updatedBy;
  int id;
  String gateName;
  String description;
  String status;
  bool isSelected = false;

  GatesContent({
    required this.createdOn,
    required this.createdBy,
    required this.updatedOn,
    required this.updatedBy,
    required this.id,
    required this.gateName,
    required this.description,
    required this.status,
    this.isSelected = false,
  });

  factory GatesContent.fromJson(Map<String, dynamic> json) => GatesContent(
        createdOn: DateTime.parse(json["createdOn"]),
        createdBy: json["createdBy"],
        updatedOn: DateTime.parse(json["updatedOn"]),
        updatedBy: json["updatedBy"],
        id: json["id"],
        gateName: json["gateName"],
        description: json["description"],
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
        "status": status,
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
