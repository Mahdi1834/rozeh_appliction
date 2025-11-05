/// success : true
/// message : "لیست مداح ها با موفقیت ارسال شد."
/// data : {"maddah":[{"id":3,"full_name":"maddah","national_code":"2565","email":"m@gmail.com","email_verified_at":"2025-10-29T11:27:30.000000Z","mobile":"09171112233","mobile_verified_at":"2025-10-29T11:27:30.000000Z","telephone":"097","address":"ddd","isSetProfile":1,"created_at":"2025-10-29T11:27:30.000000Z","updated_at":"2025-10-29T11:27:30.000000Z","deleted_at":null,"province_id":null,"city_id":null}]}

class MaddahModel {
  MaddahModel({this.success, this.message, this.data});

  MaddahModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  MaddahModel copyWith({bool? success, String? message, Data? data}) =>
      MaddahModel(
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

/// maddah : [{"id":3,"full_name":"maddah","national_code":"2565","email":"m@gmail.com","email_verified_at":"2025-10-29T11:27:30.000000Z","mobile":"09171112233","mobile_verified_at":"2025-10-29T11:27:30.000000Z","telephone":"097","address":"ddd","isSetProfile":1,"created_at":"2025-10-29T11:27:30.000000Z","updated_at":"2025-10-29T11:27:30.000000Z","deleted_at":null,"province_id":null,"city_id":null}]

class Data {
  Data({this.maddah});

  Data.fromJson(dynamic json) {
    if (json['maddah'] != null) {
      maddah = [];
      json['maddah'].forEach((v) {
        maddah?.add(Maddah.fromJson(v));
      });
    }
  }

  List<Maddah>? maddah;

  Data copyWith({List<Maddah>? maddah}) => Data(maddah: maddah ?? this.maddah);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (maddah != null) {
      map['maddah'] = maddah?.map((v) => v.toJson()).toList();
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

class Maddah {
  Maddah({
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
  });

  Maddah.fromJson(dynamic json) {
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

  Maddah copyWith({
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
  }) => Maddah(
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
    return map;
  }
}
