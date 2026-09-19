/// success : true
/// message : "مراسم نیابتی با موفقیت حذف شد"

class DeleteNiyabatModel {
  DeleteNiyabatModel({
      this.success, 
      this.message,});

  DeleteNiyabatModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;
DeleteNiyabatModel copyWith({  bool? success,
  String? message,
}) => DeleteNiyabatModel(  success: success ?? this.success,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }

}