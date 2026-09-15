/// success : true
/// message : "بنرها با موفقیت ارسال شدند"
/// data : {"banners":[{"id":3,"title":"بنر 1","image_path":"banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png","link_url":null,"sort_order":0,"is_active":true,"created_at":"2026-09-15T06:19:49.000000Z","updated_at":"2026-09-15T06:19:49.000000Z","deleted_at":null,"image_url":"http://127.0.0.1:8000/storage/banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png"},{"id":4,"title":"بنر 2","image_path":"banners/01M2HVHZVZXMKFNGE82JCQABBC.png","link_url":null,"sort_order":1,"is_active":true,"created_at":"2026-09-15T06:20:05.000000Z","updated_at":"2026-09-15T06:20:05.000000Z","deleted_at":null,"image_url":"http://127.0.0.1:8000/storage/banners/01M2HVHZVZXMKFNGE82JCQABBC.png"}]}

class BannersModel {
  BannersModel({
      this.success, 
      this.message, 
      this.data,});

  BannersModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
BannersModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => BannersModel(  success: success ?? this.success,
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

/// banners : [{"id":3,"title":"بنر 1","image_path":"banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png","link_url":null,"sort_order":0,"is_active":true,"created_at":"2026-09-15T06:19:49.000000Z","updated_at":"2026-09-15T06:19:49.000000Z","deleted_at":null,"image_url":"http://127.0.0.1:8000/storage/banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png"},{"id":4,"title":"بنر 2","image_path":"banners/01M2HVHZVZXMKFNGE82JCQABBC.png","link_url":null,"sort_order":1,"is_active":true,"created_at":"2026-09-15T06:20:05.000000Z","updated_at":"2026-09-15T06:20:05.000000Z","deleted_at":null,"image_url":"http://127.0.0.1:8000/storage/banners/01M2HVHZVZXMKFNGE82JCQABBC.png"}]

class Data {
  Data({
      this.banners,});

  Data.fromJson(dynamic json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners?.add(Banners.fromJson(v));
      });
    }
  }
  List<Banners>? banners;
Data copyWith({  List<Banners>? banners,
}) => Data(  banners: banners ?? this.banners,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 3
/// title : "بنر 1"
/// image_path : "banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png"
/// link_url : null
/// sort_order : 0
/// is_active : true
/// created_at : "2026-09-15T06:19:49.000000Z"
/// updated_at : "2026-09-15T06:19:49.000000Z"
/// deleted_at : null
/// image_url : "http://127.0.0.1:8000/storage/banners/01M2HVHFW4XEH3Y4BN37F6P1ZG.png"

class Banners {
  Banners({
      this.id, 
      this.title, 
      this.imagePath, 
      this.linkUrl, 
      this.sortOrder, 
      this.isActive, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt, 
      this.imageUrl,});

  Banners.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    imagePath = json['image_path'];
    linkUrl = json['link_url'];
    sortOrder = json['sort_order'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    imageUrl = json['image_url'];
  }
  num? id;
  String? title;
  String? imagePath;
  dynamic linkUrl;
  num? sortOrder;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? imageUrl;
Banners copyWith({  num? id,
  String? title,
  String? imagePath,
  dynamic linkUrl,
  num? sortOrder,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  String? imageUrl,
}) => Banners(  id: id ?? this.id,
  title: title ?? this.title,
  imagePath: imagePath ?? this.imagePath,
  linkUrl: linkUrl ?? this.linkUrl,
  sortOrder: sortOrder ?? this.sortOrder,
  isActive: isActive ?? this.isActive,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  deletedAt: deletedAt ?? this.deletedAt,
  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image_path'] = imagePath;
    map['link_url'] = linkUrl;
    map['sort_order'] = sortOrder;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['image_url'] = imageUrl;
    return map;
  }

}