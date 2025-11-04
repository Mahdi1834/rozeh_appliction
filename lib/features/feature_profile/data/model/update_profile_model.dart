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
    this.provinceId,
    this.cityId,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    nationalCode = json['national_code']?.toString();
    mobile = json['mobile'];
    mobileVerifiedAt = json['mobile_verified_at'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    telephone = json['telephone']?.toString();
    address = json['address'];
    postalCode = json['postal_code']?.toString();
    isSetProfile = json['isSetProfile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    provinceId = json['province_id']?.toString();
    cityId = json['city_id']?.toString();
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
  String? provinceId;
  String? cityId;

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
    String? provinceId,
    String? cityId,
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
