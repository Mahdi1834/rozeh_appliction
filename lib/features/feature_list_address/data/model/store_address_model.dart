/// success : true
/// message : "آدرس با موفقیت ثبت شد"
/// data : {"title":"خانه","address":"فارس جهرم مصطفی خمینی","postal_code":"245566","province_id":"10","city_id":"10","latitude":"10.0000000","longitude":"20.0000000","is_default":true,"customer_id":1,"updated_at":"2026-09-13T10:06:47.000000Z","created_at":"2026-09-13T10:06:47.000000Z","id":1,"province":{"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true},"city":{"id":10,"name":"آبدان","province_id":7,"county_id":197,"sector_id":2,"code":"1805032484","short_code":"2484","status":true}}

class StoreAddressModel {
  StoreAddressModel({this.success, this.message, this.data});

  StoreAddressModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  StoreAddressModel copyWith({bool? success, String? message, Data? data}) =>
      StoreAddressModel(
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

/// title : "خانه"
/// address : "فارس جهرم مصطفی خمینی"
/// postal_code : "245566"
/// province_id : "10"
/// city_id : "10"
/// latitude : "10.0000000"
/// longitude : "20.0000000"
/// is_default : true
/// customer_id : 1
/// updated_at : "2026-09-13T10:06:47.000000Z"
/// created_at : "2026-09-13T10:06:47.000000Z"
/// id : 1
/// province : {"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true}
/// city : {"id":10,"name":"آبدان","province_id":7,"county_id":197,"sector_id":2,"code":"1805032484","short_code":"2484","status":true}

class Data {
  Data({
    this.title,
    this.address,
    this.postalCode,
    this.provinceId,
    this.cityId,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.customerId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.province,
    this.city,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    address = json['address'];
    postalCode = json['postal_code'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    customerId = json['customer_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    province =
        json['province'] != null ? Province.fromJson(json['province']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }

  String? title;
  String? address;
  String? postalCode;
  num? provinceId;
  num? cityId;
  String? latitude;
  String? longitude;
  bool? isDefault;
  num? customerId;
  String? updatedAt;
  String? createdAt;
  num? id;
  Province? province;
  City? city;

  Data copyWith({
    String? title,
    String? address,
    String? postalCode,
    num? provinceId,
    num? cityId,
    String? latitude,
    String? longitude,
    bool? isDefault,
    num? customerId,
    String? updatedAt,
    String? createdAt,
    num? id,
    Province? province,
    City? city,
  }) => Data(
    title: title ?? this.title,
    address: address ?? this.address,
    postalCode: postalCode ?? this.postalCode,
    provinceId: provinceId ?? this.provinceId,
    cityId: cityId ?? this.cityId,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    isDefault: isDefault ?? this.isDefault,
    customerId: customerId ?? this.customerId,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
    id: id ?? this.id,
    province: province ?? this.province,
    city: city ?? this.city,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['address'] = address;
    map['postal_code'] = postalCode;
    map['province_id'] = provinceId;
    map['city_id'] = cityId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_default'] = isDefault;
    map['customer_id'] = customerId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    if (province != null) {
      map['province'] = province?.toJson();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    return map;
  }
}

/// id : 10
/// name : "آبدان"
/// province_id : 7
/// county_id : 197
/// sector_id : 2
/// code : "1805032484"
/// short_code : "2484"
/// status : true

class City {
  City({
    this.id,
    this.name,
    this.provinceId,
    this.countyId,
    this.sectorId,
    this.code,
    this.shortCode,
    this.status,
  });

  City.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
    countyId = json['county_id'];
    sectorId = json['sector_id'];
    code = json['code'];
    shortCode = json['short_code'];
    status = json['status'];
  }

  num? id;
  String? name;
  num? provinceId;
  num? countyId;
  num? sectorId;
  String? code;
  String? shortCode;
  bool? status;

  City copyWith({
    num? id,
    String? name,
    num? provinceId,
    num? countyId,
    num? sectorId,
    String? code,
    String? shortCode,
    bool? status,
  }) => City(
    id: id ?? this.id,
    name: name ?? this.name,
    provinceId: provinceId ?? this.provinceId,
    countyId: countyId ?? this.countyId,
    sectorId: sectorId ?? this.sectorId,
    code: code ?? this.code,
    shortCode: shortCode ?? this.shortCode,
    status: status ?? this.status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['province_id'] = provinceId;
    map['county_id'] = countyId;
    map['sector_id'] = sectorId;
    map['code'] = code;
    map['short_code'] = shortCode;
    map['status'] = status;
    return map;
  }
}

/// id : 10
/// name : "خراسان جنوبی"
/// code : "29"
/// short_code : "29"
/// status : true

class Province {
  Province({this.id, this.name, this.code, this.shortCode, this.status});

  Province.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    shortCode = json['short_code'];
    status = json['status'];
  }

  num? id;
  String? name;
  String? code;
  String? shortCode;
  bool? status;

  Province copyWith({
    num? id,
    String? name,
    String? code,
    String? shortCode,
    bool? status,
  }) => Province(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    shortCode: shortCode ?? this.shortCode,
    status: status ?? this.status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['short_code'] = shortCode;
    map['status'] = status;
    return map;
  }
}
