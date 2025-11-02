/// LoginModel
/// ساختار عمومی پاسخ API در لاراول:
/// {
///   "success": true,
///   "message": "کد با موفقیت ارسال شد",
///   "data": []
/// }

class LoginModel {
  bool? success;
  String? message;
  dynamic data; // ممکن است list یا map یا null باشد

  LoginModel({
    this.success,
    this.message,
    this.data,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

  LoginModel copyWith({
    bool? success,
    String? message,
    dynamic data,
  }) =>
      LoginModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );
}
