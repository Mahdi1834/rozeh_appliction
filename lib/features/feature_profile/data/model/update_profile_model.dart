/// success : true
/// message : "اطلاعات پروفایل با موفقیت ثبت شد"
/// data : {"id":1,"full_name":"mahdi","national_code":"2460300000","mobile":"09178901834","mobile_verified_at":"2025-11-03T07:24:48.000000Z","email":null,"email_verified_at":null,"telephone":"5447921254","address":"جهرم بلوار رهبری","postal_code":"458118782","isSetProfile":1,"created_at":"2025-10-29T06:22:45.000000Z","updated_at":"2025-11-03T07:24:48.000000Z","deleted_at":null}

class UpdateProfileModel {
  UpdateProfileModel({this.success, this.message, this.data});

  UpdateProfileModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  UpdateProfileModel copyWith({bool? success, String? message, Data? data}) =>
      UpdateProfileModel(
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

/// id : 1
/// full_name : "mahdi"
/// national_code : "2460300000"
/// mobile : "09178901834"
/// mobile_verified_at : "2025-11-03T07:24:48.000000Z"
/// email : null
/// email_verified_at : null
/// telephone : "5447921254"
/// address : "جهرم بلوار رهبری"
/// postal_code : "458118782"
/// isSetProfile : 1
/// created_at : "2025-10-29T06:22:45.000000Z"
/// updated_at : "2025-11-03T07:24:48.000000Z"
/// deleted_at : null

class Data {
  Data({
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
  });

  Data.fromJson(dynamic json) {
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

  Data copyWith({
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
  }) => Data(
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
    return map;
  }
}
