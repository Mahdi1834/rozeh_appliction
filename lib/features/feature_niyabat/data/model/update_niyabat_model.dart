/// success : true
/// message : "مراسم نیابتی با موفقیت بروزرسانی شد"
/// data : {"id":13,"customer_id":1,"address_id":null,"intention_id":1,"tavaslat_id":1,"title":"title 1dfdbdb","description":"dedfdss","date":null,"start_time":null,"end_time":null,"status":1,"created_at":"2026-09-19T07:15:20.000000Z","updated_at":"2026-09-19T07:17:05.000000Z","deleted_at":null,"intention":{"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null},"tavaslat":{"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}}

class UpdateNiyabatModel {
  UpdateNiyabatModel({
      this.success, 
      this.message, 
      this.data,});

  UpdateNiyabatModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
UpdateNiyabatModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => UpdateNiyabatModel(  success: success ?? this.success,
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

/// id : 13
/// customer_id : 1
/// address_id : null
/// intention_id : 1
/// tavaslat_id : 1
/// title : "title 1dfdbdb"
/// description : "dedfdss"
/// date : null
/// start_time : null
/// end_time : null
/// status : 1
/// created_at : "2026-09-19T07:15:20.000000Z"
/// updated_at : "2026-09-19T07:17:05.000000Z"
/// deleted_at : null
/// intention : {"id":1,"title":"وفات ","description":null,"is_active":true,"created_at":"2026-09-12T07:56:54.000000Z","updated_at":"2026-09-12T08:33:25.000000Z","deleted_at":null}
/// tavaslat : {"id":1,"title":"امام سجاد (ع)","description":null,"is_active":true,"created_at":"2026-09-12T08:33:46.000000Z","updated_at":"2026-09-12T08:36:49.000000Z","deleted_at":null}

class Data {
  Data({
      this.id, 
      this.customerId, 
      this.addressId, 
      this.intentionId, 
      this.tavaslatId, 
      this.title, 
      this.description, 
      this.date, 
      this.startTime, 
      this.endTime, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.intention, 
      this.tavaslat,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customer_id'];
    addressId = json['address_id'];
    intentionId = json['intention_id'];
    tavaslatId = json['tavaslat_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    intention = json['intention'] != null ? Intention.fromJson(json['intention']) : null;
    tavaslat = json['tavaslat'] != null ? Tavaslat.fromJson(json['tavaslat']) : null;
  }
  num? id;
  num? customerId;
  dynamic addressId;
  num? intentionId;
  num? tavaslatId;
  String? title;
  String? description;
  dynamic date;
  dynamic startTime;
  dynamic endTime;
  num? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Intention? intention;
  Tavaslat? tavaslat;
Data copyWith({  num? id,
  num? customerId,
  dynamic addressId,
  num? intentionId,
  num? tavaslatId,
  String? title,
  String? description,
  dynamic date,
  dynamic startTime,
  dynamic endTime,
  num? status,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  Intention? intention,
  Tavaslat? tavaslat,
}) => Data(  id: id ?? this.id,
  customerId: customerId ?? this.customerId,
  addressId: addressId ?? this.addressId,
  intentionId: intentionId ?? this.intentionId,
  tavaslatId: tavaslatId ?? this.tavaslatId,
  title: title ?? this.title,
  description: description ?? this.description,
  date: date ?? this.date,
  startTime: startTime ?? this.startTime,
  endTime: endTime ?? this.endTime,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
  intention: intention ?? this.intention,
  tavaslat: tavaslat ?? this.tavaslat,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_id'] = customerId;
    map['address_id'] = addressId;
    map['intention_id'] = intentionId;
    map['tavaslat_id'] = tavaslatId;
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
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
  dynamic description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
Tavaslat copyWith({  num? id,
  String? title,
  dynamic description,
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
  dynamic description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
Intention copyWith({  num? id,
  String? title,
  dynamic description,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
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