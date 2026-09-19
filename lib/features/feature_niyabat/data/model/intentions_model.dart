/// success : true
/// message : "لیست نیت‌ها با موفقیت ارسال شد"
/// data : {"intentions":[{"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null}]}

class IntentionsModel {
  IntentionsModel({
      this.success, 
      this.message, 
      this.data,});

  IntentionsModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
IntentionsModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => IntentionsModel(  success: success ?? this.success,
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

/// intentions : [{"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null}]

class Data {
  Data({
      this.intentions,});

  Data.fromJson(dynamic json) {
    if (json['intentions'] != null) {
      intentions = [];
      json['intentions'].forEach((v) {
        intentions?.add(Intentions.fromJson(v));
      });
    }
  }
  List<Intentions>? intentions;
Data copyWith({  List<Intentions>? intentions,
}) => Data(  intentions: intentions ?? this.intentions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (intentions != null) {
      map['intentions'] = intentions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "وفات "
/// description : null
/// is_active : true
/// created_at : "2026-09-12T07:56:54.000000Z"
/// updated_at : "2026-09-12T08:33:25.000000Z"
/// deleted_at : null

class Intentions {
  Intentions({
      this.id, 
      this.title, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Intentions.fromJson(dynamic json) {
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
Intentions copyWith({  num? id,
  String? title,
  dynamic description,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => Intentions(  id: id ?? this.id,
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