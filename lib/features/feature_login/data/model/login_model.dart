class LoginModel {
  bool? success;
  String? message;
  LoginData? data;

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? LoginData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }

  LoginModel copyWith({
    bool? success,
    String? message,
    LoginData? data,
  }) {
    return LoginModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
class LoginData {
  String? code;

  LoginData({this.code});

  LoginData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
    };
  }
}
