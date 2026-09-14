/// success : true
/// message : "لیست آدرس‌ها با موفقیت ارسال شد"
/// data : {"addresses":[{"id":1,"customer_id":1,"title":"خانه","address":"فارس جهرم مصطفی خمینی","postal_code":"245566","province_id":10,"city_id":10,"latitude":"10.0000000","longitude":"20.0000000","is_default":true,"created_at":"2026-09-13T10:06:47.000000Z","updated_at":"2026-09-13T10:06:47.000000Z","province":{"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true},"city":{"id":10,"name":"آبدان","province_id":7,"county_id":197,"sector_id":2,"code":"1805032484","short_code":"2484","status":true}}]}

class ListAddressModel {
  ListAddressModel({
      this.success, 
      this.message, 
      this.data,});

  ListAddressModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Data? data;
ListAddressModel copyWith({  bool? success,
  String? message,
  Data? data,
}) => ListAddressModel(  success: success ?? this.success,
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

/// addresses : [{"id":1,"customer_id":1,"title":"خانه","address":"فارس جهرم مصطفی خمینی","postal_code":"245566","province_id":10,"city_id":10,"latitude":"10.0000000","longitude":"20.0000000","is_default":true,"created_at":"2026-09-13T10:06:47.000000Z","updated_at":"2026-09-13T10:06:47.000000Z","province":{"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true},"city":{"id":10,"name":"آبدان","province_id":7,"county_id":197,"sector_id":2,"code":"1805032484","short_code":"2484","status":true}}]

class Data {
  Data({
      this.addresses,});

  Data.fromJson(dynamic json) {
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(Addresses.fromJson(v));
      });
    }
  }
  List<Addresses>? addresses;
Data copyWith({  List<Addresses>? addresses,
}) => Data(  addresses: addresses ?? this.addresses,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// customer_id : 1
/// title : "خانه"
/// address : "فارس جهرم مصطفی خمینی"
/// postal_code : "245566"
/// province_id : 10
/// city_id : 10
/// latitude : "10.0000000"
/// longitude : "20.0000000"
/// is_default : true
/// created_at : "2026-09-13T10:06:47.000000Z"
/// updated_at : "2026-09-13T10:06:47.000000Z"
/// province : {"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true}
/// city : {"id":10,"name":"آبدان","province_id":7,"county_id":197,"sector_id":2,"code":"1805032484","short_code":"2484","status":true}

class Addresses {
  Addresses({
      this.id, 
      this.customerId, 
      this.title, 
      this.address, 
      this.postalCode, 
      this.provinceId, 
      this.cityId, 
      this.latitude, 
      this.longitude, 
      this.isDefault, 
      this.createdAt, 
      this.updatedAt, 
      this.province, 
      this.city,});

  Addresses.fromJson(dynamic json) {
    id = json['id'];
    customerId = json['customer_id'];
    title = json['title'];
    address = json['address'];
    postalCode = json['postal_code'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    province = json['province'] != null ? Province.fromJson(json['province']) : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
  num? id;
  num? customerId;
  String? title;
  String? address;
  String? postalCode;
  num? provinceId;
  num? cityId;
  String? latitude;
  String? longitude;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  Province? province;
  City? city;
Addresses copyWith({  num? id,
  num? customerId,
  String? title,
  String? address,
  String? postalCode,
  num? provinceId,
  num? cityId,
  String? latitude,
  String? longitude,
  bool? isDefault,
  String? createdAt,
  String? updatedAt,
  Province? province,
  City? city,
}) => Addresses(  id: id ?? this.id,
  customerId: customerId ?? this.customerId,
  title: title ?? this.title,
  address: address ?? this.address,
  postalCode: postalCode ?? this.postalCode,
  provinceId: provinceId ?? this.provinceId,
  cityId: cityId ?? this.cityId,
  latitude: latitude ?? this.latitude,
  longitude: longitude ?? this.longitude,
  isDefault: isDefault ?? this.isDefault,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  province: province ?? this.province,
  city: city ?? this.city,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['customer_id'] = customerId;
    map['title'] = title;
    map['address'] = address;
    map['postal_code'] = postalCode;
    map['province_id'] = provinceId;
    map['city_id'] = cityId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['is_default'] = isDefault;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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
      this.status,});

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
City copyWith({  num? id,
  String? name,
  num? provinceId,
  num? countyId,
  num? sectorId,
  String? code,
  String? shortCode,
  bool? status,
}) => City(  id: id ?? this.id,
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
  Province({
      this.id, 
      this.name, 
      this.code, 
      this.shortCode, 
      this.status,});

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
Province copyWith({  num? id,
  String? name,
  String? code,
  String? shortCode,
  bool? status,
}) => Province(  id: id ?? this.id,
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