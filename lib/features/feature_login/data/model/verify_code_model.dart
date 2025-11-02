/// success : true
/// message : "کد با موفقیت تأیید شد."
/// data : {"customer":{"id":2,"full_name":null,"national_code":null,"mobile":"09111111111","mobile_verified_at":"2025-11-02T10:29:31.000000Z","email":null,"email_verified_at":null,"telephone":null,"address":null,"postal_code":null,"isSetProfile":0,"created_at":"2025-10-29T08:25:20.000000Z","updated_at":"2025-11-02T10:29:31.000000Z","deleted_at":null},"token":"6|LTDhdsUaVjeHnVqGvZrzh1DWisgh7mpDa1yX6eMI0780318f"}

class VerifyCodeModel {
  VerifyCodeModel({this.success, this.message, this.data});

  VerifyCodeModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  VerifyCodeModel copyWith({bool? success, String? message, Data? data}) =>
      VerifyCodeModel(
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

/// customer : {"id":2,"full_name":null,"national_code":null,"mobile":"09111111111","mobile_verified_at":"2025-11-02T10:29:31.000000Z","email":null,"email_verified_at":null,"telephone":null,"address":null,"postal_code":null,"isSetProfile":0,"created_at":"2025-10-29T08:25:20.000000Z","updated_at":"2025-11-02T10:29:31.000000Z","deleted_at":null}
/// token : "6|LTDhdsUaVjeHnVqGvZrzh1DWisgh7mpDa1yX6eMI0780318f"

class Data {
  Data({this.customer, this.token});

  Data.fromJson(dynamic json) {
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    token = json['token'];
  }

  Customer? customer;
  String? token;

  Data copyWith({Customer? customer, String? token}) =>
      Data(customer: customer ?? this.customer, token: token ?? this.token);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    map['token'] = token;
    return map;
  }
}

/// id : 2
/// full_name : null
/// national_code : null
/// mobile : "09111111111"
/// mobile_verified_at : "2025-11-02T10:29:31.000000Z"
/// email : null
/// email_verified_at : null
/// telephone : null
/// address : null
/// postal_code : null
/// isSetProfile : 0
/// created_at : "2025-10-29T08:25:20.000000Z"
/// updated_at : "2025-11-02T10:29:31.000000Z"
/// deleted_at : null

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
  }

  num? id;
  dynamic fullName;
  dynamic nationalCode;
  String? mobile;
  String? mobileVerifiedAt;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic telephone;
  dynamic address;
  dynamic postalCode;
  num? isSetProfile;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Customer copyWith({
    num? id,
    dynamic fullName,
    dynamic nationalCode,
    String? mobile,
    String? mobileVerifiedAt,
    dynamic email,
    dynamic emailVerifiedAt,
    dynamic telephone,
    dynamic address,
    dynamic postalCode,
    num? isSetProfile,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
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
