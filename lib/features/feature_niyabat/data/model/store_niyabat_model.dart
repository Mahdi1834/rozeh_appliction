/// success : true
/// message : "مراسم نیابتی با موفقیت ثبت شد"
/// data : {"customer_id":1,"intention_id":"1","tavaslat_id":"1","title":"title 1","description":"dess","status":1,"updated_at":"2026-09-19T07:18:39.000000Z","created_at":"2026-09-19T07:18:39.000000Z","id":14,"intention":{"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null},"tavaslat":{"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}}

class StoreNiyabatModel {
  StoreNiyabatModel({
      this.success, 
      this.message, 
      this.data,});

  StoreNiyabatModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
StoreNiyabatModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => StoreNiyabatModel(  success: success ?? this.success,
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

/// customer_id : 1
/// intention_id : "1"
/// tavaslat_id : "1"
/// title : "title 1"
/// description : "dess"
/// status : 1
/// updated_at : "2026-09-19T07:18:39.000000Z"
/// created_at : "2026-09-19T07:18:39.000000Z"
/// id : 14
/// intention : {"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null}
/// tavaslat : {"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}

class Data {
  Data({
      this.customerId, 
      this.intentionId, 
      this.tavaslatId, 
      this.title, 
      this.description, 
      this.status, 
      this.updatedAt, 
      this.createdAt, 
      this.id, 
      this.intention, 
      this.tavaslat,});

  Data.fromJson(dynamic json) {
    customerId = json['customer_id'];
    intentionId = json['intention_id'];
    tavaslatId = json['tavaslat_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    intention = json['intention'] != null ? Intention.fromJson(json['intention']) : null;
    tavaslat = json['tavaslat'] != null ? Tavaslat.fromJson(json['tavaslat']) : null;
  }
  num? customerId;
  num? intentionId;
  num? tavaslatId;
  String? title;
  String? description;
  num? status;
  String? updatedAt;
  String? createdAt;
  num? id;
  Intention? intention;
  Tavaslat? tavaslat;
Data copyWith({
  num? customerId,
  num? intentionId,
  num? tavaslatId,
  String? title,
  String? description,
  num? status,
  String? updatedAt,
  String? createdAt,
  num? id,
  Intention? intention,
  Tavaslat? tavaslat,
}) => Data(  customerId: customerId ?? this.customerId,
  intentionId: intentionId ?? this.intentionId,
  tavaslatId: tavaslatId ?? this.tavaslatId,
  title: title ?? this.title,
  description: description ?? this.description,
  status: status ?? this.status,
  updatedAt: updatedAt ?? this.updatedAt,
  createdAt: createdAt ?? this.createdAt,
  id: id ?? this.id,
  intention: intention ?? this.intention,
  tavaslat: tavaslat ?? this.tavaslat,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['intention_id'] = intentionId;
    map['tavaslat_id'] = tavaslatId;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    if (intention != null) {
      map['intention'] = intention?.toJson();
    }
    if (tavaslat != null) {
      map['tavaslat'] = tavaslat?.toJson();
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

class Tavaslat {
  Tavaslat({
      this.id, 
      this.title, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Tavaslat.fromJson(dynamic json) {
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
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
Tavaslat copyWith({  num? id,
  String? title,
  String? description,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
}) => Tavaslat(  id: id ?? this.id,
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

/// id : 1
/// title : "وفات "
/// description : null
/// is_active : true
/// created_at : "2026-09-12T07:56:54.000000Z"
/// updated_at : "2026-09-12T08:33:25.000000Z"
/// deleted_at : null

class Intention {
  Intention({
      this.id, 
      this.title, 
      this.description, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Intention.fromJson(dynamic json) {
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
  String? description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
Intention copyWith({  num? id,
  String? title,
  String? description,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
}) => Intention(  id: id ?? this.id,
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