/// success : true
/// message : "لیست سخنران با موفقیت ارسال شد."
/// data : {"speaker":[{"id":4,"full_name":"سخنران","national_code":"8888","email":"S@gmail.com","email_verified_at":"2025-10-29T11:28:43.000000Z","mobile":"09172223344","mobile_verified_at":"2025-10-29T11:28:43.000000Z","telephone":"18451","address":"dfvdfvdvd","isSetProfile":1,"created_at":"2025-10-29T11:28:43.000000Z","updated_at":"2025-10-29T11:28:43.000000Z","deleted_at":null,"province_id":null,"city_id":null}]}

class SpeakerModel {
  SpeakerModel({this.success, this.message, this.data});

  SpeakerModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  SpeakerModel copyWith({bool? success, String? message, Data? data}) =>
      SpeakerModel(
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

/// speaker : [{"id":4,"full_name":"سخنران","national_code":"8888","email":"S@gmail.com","email_verified_at":"2025-10-29T11:28:43.000000Z","mobile":"09172223344","mobile_verified_at":"2025-10-29T11:28:43.000000Z","telephone":"18451","address":"dfvdfvdvd","isSetProfile":1,"created_at":"2025-10-29T11:28:43.000000Z","updated_at":"2025-10-29T11:28:43.000000Z","deleted_at":null,"province_id":null,"city_id":null}]

class Data {
  Data({this.speaker});

  Data.fromJson(dynamic json) {
    if (json['speaker'] != null) {
      speaker = [];
      json['speaker'].forEach((v) {
        speaker?.add(Speaker.fromJson(v));
      });
    }
  }

  List<Speaker>? speaker;

  Data copyWith({List<Speaker>? speaker}) =>
      Data(speaker: speaker ?? this.speaker);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (speaker != null) {
      map['speaker'] = speaker?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 4
/// full_name : "سخنران"
/// national_code : "8888"
/// email : "S@gmail.com"
/// email_verified_at : "2025-10-29T11:28:43.000000Z"
/// mobile : "09172223344"
/// mobile_verified_at : "2025-10-29T11:28:43.000000Z"
/// telephone : "18451"
/// address : "dfvdfvdvd"
/// isSetProfile : 1
/// created_at : "2025-10-29T11:28:43.000000Z"
/// updated_at : "2025-10-29T11:28:43.000000Z"
/// deleted_at : null
/// province_id : null
/// city_id : null

class Speaker {
  Speaker({
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

  Speaker.fromJson(dynamic json) {
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

  Speaker copyWith({
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
  }) => Speaker(
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
