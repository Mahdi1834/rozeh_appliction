/// success : true
/// message : "آدرس با موفقیت حذف شد"

class DeleteAddressModel {
  DeleteAddressModel({
      this.success, 
      this.message,});

  DeleteAddressModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
DeleteAddressModel copyWith({  bool? success,
  String? message,
}) => DeleteAddressModel(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}