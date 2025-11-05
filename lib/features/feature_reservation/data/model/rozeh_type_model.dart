/// success : true
/// message : "نوع داده با موفقیت ارسال شد."
/// data : {"rozeh":[{"id":1,"title":"وفات","created_at":"2025-10-29T08:59:08.000000Z","updated_at":"2025-10-29T08:59:08.000000Z"},{"id":2,"title":"جشن","created_at":"2025-10-29T08:59:18.000000Z","updated_at":"2025-10-29T08:59:18.000000Z"}]}

class RozehTypeModel {
  RozehTypeModel({this.success, this.message, this.data});

  RozehTypeModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  RozehTypeModel copyWith({bool? success, String? message, Data? data}) =>
      RozehTypeModel(
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

/// rozeh : [{"id":1,"title":"وفات","created_at":"2025-10-29T08:59:08.000000Z","updated_at":"2025-10-29T08:59:08.000000Z"},{"id":2,"title":"جشن","created_at":"2025-10-29T08:59:18.000000Z","updated_at":"2025-10-29T08:59:18.000000Z"}]

class Data {
  Data({this.rozeh});

  Data.fromJson(dynamic json) {
    if (json['rozeh'] != null) {
      rozeh = [];
      json['rozeh'].forEach((v) {
        rozeh?.add(Rozeh.fromJson(v));
      });
    }
  }

  List<Rozeh>? rozeh;

  Data copyWith({List<Rozeh>? rozeh}) => Data(rozeh: rozeh ?? this.rozeh);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (rozeh != null) {
      map['rozeh'] = rozeh?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// title : "وفات"
/// created_at : "2025-10-29T08:59:08.000000Z"
/// updated_at : "2025-10-29T08:59:08.000000Z"

class Rozeh {
  Rozeh({this.id, this.title, this.createdAt, this.updatedAt});

  Rozeh.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  Rozeh copyWith({
    num? id,
    String? title,
    String? createdAt,
    String? updatedAt,
  }) => Rozeh(
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
