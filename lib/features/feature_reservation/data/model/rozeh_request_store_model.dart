/// success : true
/// message : "درخواست روضه با موفقیت ثبت شد"
/// data : {"customer_id":1,"rozeh_id":"1","age_group_id":"1","gender":"family","description":"description","date":"2025-11-09","start_time":"10:00","end_time":"16:00","updated_at":"2025-11-05T06:48:15.000000Z","created_at":"2025-11-05T06:48:15.000000Z","id":23,"customer":{"id":1,"full_name":"mahdi","national_code":"2460300000","mobile":"09178901834","mobile_verified_at":"2025-11-05T06:04:50.000000Z","email":null,"email_verified_at":null,"telephone":"5447921254","address":"جهرم بلوار رهبری","postal_code":"458118782","isSetProfile":1,"created_at":"2025-10-29T06:22:45.000000Z","updated_at":"2025-11-05T06:04:50.000000Z","deleted_at":null,"province_id":17,"city_id":460},"rozeh":{"id":1,"title":"وفات","created_at":"2025-10-29T08:59:08.000000Z","updated_at":"2025-10-29T08:59:08.000000Z"},"users":[{"id":3,"full_name":"maddah","national_code":"2565","email":"m@gmail.com","email_verified_at":"2025-10-29T11:27:30.000000Z","mobile":"09171112233","mobile_verified_at":"2025-10-29T11:27:30.000000Z","telephone":"097","address":"ddd","isSetProfile":1,"created_at":"2025-10-29T11:27:30.000000Z","updated_at":"2025-10-29T11:27:30.000000Z","deleted_at":null,"province_id":null,"city_id":null,"pivot":{"rozeh_request_id":23,"user_id":3,"id":30,"created_at":"2025-11-05T06:48:15.000000Z","updated_at":"2025-11-05T06:48:15.000000Z"}},{"id":4,"full_name":"سخنران","national_code":"8888","email":"S@gmail.com","email_verified_at":"2025-10-29T11:28:43.000000Z","mobile":"09172223344","mobile_verified_at":"2025-10-29T11:28:43.000000Z","telephone":"18451","address":"dfvdfvdvd","isSetProfile":1,"created_at":"2025-10-29T11:28:43.000000Z","updated_at":"2025-10-29T11:28:43.000000Z","deleted_at":null,"province_id":null,"city_id":null,"pivot":{"rozeh_request_id":23,"user_id":4,"id":29,"created_at":"2025-11-05T06:48:15.000000Z","updated_at":"2025-11-05T06:48:15.000000Z"}}]}

class RozehRequestStoreModel {
  RozehRequestStoreModel({this.success, this.message, this.data});

  RozehRequestStoreModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  RozehRequestStoreModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) => RozehRequestStoreModel(
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

/// customer_id : 1
/// rozeh_id : "1"
/// age_group_id : "1"
/// gender : "family"
/// description : "description"
/// date : "2025-11-09"
/// start_time : "10:00"
/// end_time : "16:00"
/// updated_at : "2025-11-05T06:48:15.000000Z"
/// created_at : "2025-11-05T06:48:15.000000Z"
/// id : 23
/// customer : {"id":1,"full_name":"mahdi","national_code":"2460300000","mobile":"09178901834","mobile_verified_at":"2025-11-05T06:04:50.000000Z","email":null,"email_verified_at":null,"telephone":"5447921254","address":"جهرم بلوار رهبری","postal_code":"458118782","isSetProfile":1,"created_at":"2025-10-29T06:22:45.000000Z","updated_at":"2025-11-05T06:04:50.000000Z","deleted_at":null,"province_id":17,"city_id":460}
/// rozeh : {"id":1,"title":"وفات","created_at":"2025-10-29T08:59:08.000000Z","updated_at":"2025-10-29T08:59:08.000000Z"}
/// users : [{"id":3,"full_name":"maddah","national_code":"2565","email":"m@gmail.com","email_verified_at":"2025-10-29T11:27:30.000000Z","mobile":"09171112233","mobile_verified_at":"2025-10-29T11:27:30.000000Z","telephone":"097","address":"ddd","isSetProfile":1,"created_at":"2025-10-29T11:27:30.000000Z","updated_at":"2025-10-29T11:27:30.000000Z","deleted_at":null,"province_id":null,"city_id":null,"pivot":{"rozeh_request_id":23,"user_id":3,"id":30,"created_at":"2025-11-05T06:48:15.000000Z","updated_at":"2025-11-05T06:48:15.000000Z"}},{"id":4,"full_name":"سخنران","national_code":"8888","email":"S@gmail.com","email_verified_at":"2025-10-29T11:28:43.000000Z","mobile":"09172223344","mobile_verified_at":"2025-10-29T11:28:43.000000Z","telephone":"18451","address":"dfvdfvdvd","isSetProfile":1,"created_at":"2025-10-29T11:28:43.000000Z","updated_at":"2025-10-29T11:28:43.000000Z","deleted_at":null,"province_id":null,"city_id":null,"pivot":{"rozeh_request_id":23,"user_id":4,"id":29,"created_at":"2025-11-05T06:48:15.000000Z","updated_at":"2025-11-05T06:48:15.000000Z"}}]

class Data {
  Data({
    this.customerId,
    this.rozehId,
    this.ageGroupId,
    this.gender,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.customer,
    this.rozeh,
    this.users,
  });

  Data.fromJson(dynamic json) {
    customerId = json['customer_id'];
    // اگر عدد باشه به String تبدیل می‌کنیم
    rozehId = json['rozeh_id']?.toString();
    ageGroupId = json['age_group_id']?.toString();
    gender = json['gender'];
    description = json['description'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id']; // چون num هست، مشکلی نیست
    customer =
    json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    rozeh = json['rozeh'] != null ? Rozeh.fromJson(json['rozeh']) : null;
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
  }


  num? customerId;
  String? rozehId;
  String? ageGroupId;
  String? gender;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  String? updatedAt;
  String? createdAt;
  num? id;
  Customer? customer;
  Rozeh? rozeh;
  List<Users>? users;

  Data copyWith({
    num? customerId,
    String? rozehId,
    String? ageGroupId,
    String? gender,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    String? updatedAt,
    String? createdAt,
    num? id,
    Customer? customer,
    Rozeh? rozeh,
    List<Users>? users,
  }) => Data(
    customerId: customerId ?? this.customerId,
    rozehId: rozehId ?? this.rozehId,
    ageGroupId: ageGroupId ?? this.ageGroupId,
    gender: gender ?? this.gender,
    description: description ?? this.description,
    date: date ?? this.date,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
    id: id ?? this.id,
    customer: customer ?? this.customer,
    rozeh: rozeh ?? this.rozeh,
    users: users ?? this.users,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['rozeh_id'] = rozehId;
    map['age_group_id'] = ageGroupId;
    map['gender'] = gender;
    map['description'] = description;
    map['date'] = date;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (rozeh != null) {
      map['rozeh'] = rozeh?.toJson();
    }
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 3
/// full_name : "maddah"
/// national_code : "2565"
/// email : "m@gmail.com"
/// email_verified_at : "2025-10-29T11:27:30.000000Z"
/// mobile : "09171112233"
/// mobile_verified_at : "2025-10-29T11:27:30.000000Z"
/// telephone : "097"
/// address : "ddd"
/// isSetProfile : 1
/// created_at : "2025-10-29T11:27:30.000000Z"
/// updated_at : "2025-10-29T11:27:30.000000Z"
/// deleted_at : null
/// province_id : null
/// city_id : null
/// pivot : {"rozeh_request_id":23,"user_id":3,"id":30,"created_at":"2025-11-05T06:48:15.000000Z","updated_at":"2025-11-05T06:48:15.000000Z"}

class Users {
  Users({
    this.id,
    this.fullName,
    this.nationalCode,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.mobileVerifiedAt,
    this.telephone,
    this.address,
    this.isSetProfile,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.provinceId,
    this.cityId,
    this.pivot,
  });

  Users.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    nationalCode = json['national_code'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    telephone = json['telephone'];
    address = json['address'];
    isSetProfile = json['isSetProfile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  num? id;
  String? fullName;
  String? nationalCode;
  String? email;
  String? emailVerifiedAt;
  String? mobile;
  String? mobileVerifiedAt;
  String? telephone;
  String? address;
  num? isSetProfile;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic provinceId;
  dynamic cityId;
  Pivot? pivot;

  Users copyWith({
    num? id,
    String? fullName,
    String? nationalCode,
    String? email,
    String? emailVerifiedAt,
    String? mobile,
    String? mobileVerifiedAt,
    String? telephone,
    String? address,
    num? isSetProfile,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    dynamic provinceId,
    dynamic cityId,
    Pivot? pivot,
  }) => Users(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    nationalCode: nationalCode ?? this.nationalCode,
    email: email ?? this.email,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    mobile: mobile ?? this.mobile,
    mobileVerifiedAt: mobileVerifiedAt ?? this.mobileVerifiedAt,
    telephone: telephone ?? this.telephone,
    address: address ?? this.address,
    isSetProfile: isSetProfile ?? this.isSetProfile,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
    provinceId: provinceId ?? this.provinceId,
    cityId: cityId ?? this.cityId,
    pivot: pivot ?? this.pivot,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['national_code'] = nationalCode;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['mobile'] = mobile;
    map['mobile_verified_at'] = mobileVerifiedAt;
    map['telephone'] = telephone;
    map['address'] = address;
    map['isSetProfile'] = isSetProfile;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['province_id'] = provinceId;
    map['city_id'] = cityId;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }
}

/// rozeh_request_id : 23
/// user_id : 3
/// id : 30
/// created_at : "2025-11-05T06:48:15.000000Z"
/// updated_at : "2025-11-05T06:48:15.000000Z"

class Pivot {
  Pivot({
    this.rozehRequestId,
    this.userId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Pivot.fromJson(dynamic json) {
    rozehRequestId = json['rozeh_request_id'];
    userId = json['user_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? rozehRequestId;
  num? userId;
  num? id;
  String? createdAt;
  String? updatedAt;

  Pivot copyWith({
    num? rozehRequestId,
    num? userId,
    num? id,
    String? createdAt,
    String? updatedAt,
  }) => Pivot(
    rozehRequestId: rozehRequestId ?? this.rozehRequestId,
    userId: userId ?? this.userId,
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rozeh_request_id'] = rozehRequestId;
    map['user_id'] = userId;
    map['id'] = id;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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

/// id : 1
/// full_name : "mahdi"
/// national_code : "2460300000"
/// mobile : "09178901834"
/// mobile_verified_at : "2025-11-05T06:04:50.000000Z"
/// email : null
/// email_verified_at : null
/// telephone : "5447921254"
/// address : "جهرم بلوار رهبری"
/// postal_code : "458118782"
/// isSetProfile : 1
/// created_at : "2025-10-29T06:22:45.000000Z"
/// updated_at : "2025-11-05T06:04:50.000000Z"
/// deleted_at : null
/// province_id : 17
/// city_id : 460

class Customer {
  Customer({
    this.id,
    this.fullName,
    this.nationalCode,
    this.mobile,
    this.mobileVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.telephone,
    this.address,
    this.postalCode,
    this.isSetProfile,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.provinceId,
    this.cityId,
  });

  Customer.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    nationalCode = json['national_code'];
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    telephone = json['telephone'];
    address = json['address'];
    postalCode = json['postal_code'];
    isSetProfile = json['isSetProfile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    provinceId = json['province_id'];
    cityId = json['city_id'];
  }

  num? id;
  String? fullName;
  String? nationalCode;
  String? mobile;
  String? mobileVerifiedAt;
  dynamic email;
  dynamic emailVerifiedAt;
  String? telephone;
  String? address;
  String? postalCode;
  num? isSetProfile;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  num? provinceId;
  num? cityId;

  Customer copyWith({
    num? id,
    String? fullName,
    String? nationalCode,
    String? mobile,
    String? mobileVerifiedAt,
    dynamic email,
    dynamic emailVerifiedAt,
    String? telephone,
    String? address,
    String? postalCode,
    num? isSetProfile,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    num? provinceId,
    num? cityId,
  }) => Customer(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    nationalCode: nationalCode ?? this.nationalCode,
    mobile: mobile ?? this.mobile,
    mobileVerifiedAt: mobileVerifiedAt ?? this.mobileVerifiedAt,
    email: email ?? this.email,
    emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    telephone: telephone ?? this.telephone,
    address: address ?? this.address,
    postalCode: postalCode ?? this.postalCode,
    isSetProfile: isSetProfile ?? this.isSetProfile,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
    provinceId: provinceId ?? this.provinceId,
    cityId: cityId ?? this.cityId,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['national_code'] = nationalCode;
    map['mobile'] = mobile;
    map['mobile_verified_at'] = mobileVerifiedAt;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['telephone'] = telephone;
    map['address'] = address;
    map['postal_code'] = postalCode;
    map['isSetProfile'] = isSetProfile;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['province_id'] = provinceId;
    map['city_id'] = cityId;
    return map;
  }
}
