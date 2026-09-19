/// success : true
/// message : "لیست توسلات با موفقیت ارسال شد"
/// data : {"tavaslats":[{"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}]}

class TavaslatsModel {
  TavaslatsModel({
      this.success, 
      this.message, 
      this.data,});

  TavaslatsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
TavaslatsModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => TavaslatsModel(  success: success ?? this.success,
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

/// tavaslats : [{"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}]

class Data {
  Data({
      this.tavaslats,});

  Data.fromJson(dynamic json) {
    if (json['tavaslats'] != null) {
      tavaslats = [];
      json['tavaslats'].forEach((v) {
        tavaslats?.add(Tavaslats.fromJson(v));
      });
    }
  }
  List<Tavaslats>? tavaslats;
Data copyWith({  List<Tavaslats>? tavaslats,
}) => Data(  tavaslats: tavaslats ?? this.tavaslats,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tavaslats != null) {
      map['tavaslats'] = tavaslats?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "امام سجاد (ع)"
/// description : null
/// is_active : true
/// created_at : "2026-09-12T08:33:46.000000Z"
/// updated_at : "2026-09-12T08:36:49.000000Z"
/// deleted_at : null

class Tavaslats {
  Tavaslats({
      this.id, 
      this.title, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Tavaslats.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  num? id;
  String? title;
  dynamic description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
Tavaslats copyWith({  num? id,
  String? title,
  dynamic description,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => Tavaslats(  id: id ?? this.id,
  title: title ?? this.title,
  description: description ?? this.description,
  isActive: isActive ?? this.isActive,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}