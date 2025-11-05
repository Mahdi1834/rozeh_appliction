/// success : true
/// message : "گروه سنی با موفقیت ارسال شد."
/// data : {"ageGroup":[{"id":1,"title":"کودک","created_at":"2025-10-29T06:13:40.000000Z","updated_at":"2025-10-29T06:13:40.000000Z"},{"id":2,"title":"نوجوان","created_at":"2025-10-29T06:13:40.000000Z","updated_at":"2025-10-29T06:13:40.000000Z"},{"id":3,"title":"بزرگسال","created_at":"2025-10-29T10:05:05.000000Z","updated_at":"2025-10-29T10:05:05.000000Z"}]}

class AgeGroupModel {
  AgeGroupModel({this.success, this.message, this.data});

  AgeGroupModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  AgeGroupModel copyWith({bool? success, String? message, Data? data}) =>
      AgeGroupModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// ageGroup : [{"id":1,"title":"کودک","created_at":"2025-10-29T06:13:40.000000Z","updated_at":"2025-10-29T06:13:40.000000Z"},{"id":2,"title":"نوجوان","created_at":"2025-10-29T06:13:40.000000Z","updated_at":"2025-10-29T06:13:40.000000Z"},{"id":3,"title":"بزرگسال","created_at":"2025-10-29T10:05:05.000000Z","updated_at":"2025-10-29T10:05:05.000000Z"}]

class Data {
  Data({this.ageGroup});

  Data.fromJson(dynamic json) {
    if (json['ageGroup'] != null) {
      ageGroup = [];
      json['ageGroup'].forEach((v) {
        ageGroup?.add(AgeGroup.fromJson(v));
      });
    }
  }

  List<AgeGroup>? ageGroup;

  Data copyWith({List<AgeGroup>? ageGroup}) =>
      Data(ageGroup: ageGroup ?? this.ageGroup);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ageGroup != null) {
      map['ageGroup'] = ageGroup?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// title : "کودک"
/// created_at : "2025-10-29T06:13:40.000000Z"
/// updated_at : "2025-10-29T06:13:40.000000Z"

class AgeGroup {
  AgeGroup({this.id, this.title, this.createdAt, this.updatedAt});

  AgeGroup.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  AgeGroup copyWith({
    num? id,
    String? title,
    String? createdAt,
    String? updatedAt,
  }) => AgeGroup(
    id: id ?? this.id,
    title: title ?? this.title,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
