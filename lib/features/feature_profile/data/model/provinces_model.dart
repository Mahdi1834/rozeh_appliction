/// success : true
/// message : "نام استان ها با موفقیت ارسال شد"
/// data : [{"id":1,"name":"آذربایجان شرقی","code":"03","short_code":"03","status":true},{"id":2,"name":"آذربایجان غربی","code":"04","short_code":"04","status":true},{"id":3,"name":"اردبیل","code":"24","short_code":"24","status":true},{"id":4,"name":"اصفهان","code":"10","short_code":"10","status":true},{"id":5,"name":"البرز","code":"30","short_code":"30","status":true},{"id":6,"name":"ایلام","code":"16","short_code":"16","status":true},{"id":7,"name":"بوشهر","code":"18","short_code":"18","status":true},{"id":8,"name":"تهران","code":"23","short_code":"23","status":true},{"id":9,"name":"چهارمحال و بختیاری","code":"14","short_code":"14","status":true},{"id":10,"name":"خراسان جنوبی","code":"29","short_code":"29","status":true},{"id":11,"name":"خراسان رضوی","code":"09","short_code":"09","status":true},{"id":12,"name":"خراسان شمالی","code":"28","short_code":"28","status":true},{"id":13,"name":"خوزستان","code":"06","short_code":"06","status":true},{"id":14,"name":"زنجان","code":"19","short_code":"19","status":true},{"id":15,"name":"سمنان","code":"20","short_code":"20","status":true},{"id":16,"name":"سیستان و بلوچستان","code":"11","short_code":"11","status":true},{"id":17,"name":"فارس","code":"07","short_code":"07","status":true},{"id":18,"name":"قزوین","code":"26","short_code":"26","status":true},{"id":19,"name":"قم","code":"25","short_code":"25","status":true},{"id":20,"name":"کردستان","code":"12","short_code":"12","status":true},{"id":21,"name":"کرمان","code":"08","short_code":"08","status":true},{"id":22,"name":"کرمانشاه","code":"05","short_code":"05","status":true},{"id":23,"name":"کهگیلویه و بویراحمد","code":"17","short_code":"17","status":true},{"id":24,"name":"گلستان","code":"27","short_code":"27","status":true},{"id":25,"name":"گیلان","code":"01","short_code":"01","status":true},{"id":26,"name":"لرستان","code":"15","short_code":"15","status":true},{"id":27,"name":"مازندران","code":"02","short_code":"02","status":true},{"id":28,"name":"مرکزی","code":"00","short_code":"00","status":true},{"id":29,"name":"هرمزگان","code":"22","short_code":"22","status":true},{"id":30,"name":"همدان","code":"13","short_code":"13","status":true},{"id":31,"name":"یزد","code":"21","short_code":"21","status":true}]

class ProvincesModel {
  ProvincesModel({this.success, this.message, this.data});

  ProvincesModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<Data>? data;

  ProvincesModel copyWith({bool? success, String? message, List<Data>? data}) =>
      ProvincesModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "آذربایجان شرقی"
/// code : "03"
/// short_code : "03"
/// status : true

class Data {
  Data({this.id, this.name, this.code, this.shortCode, this.status});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    shortCode = json['short_code'];
    status = json['status'];
  }

  num? id;
  String? name;
  String? code;
  String? shortCode;
  bool? status;

  Data copyWith({
    num? id,
    String? name,
    String? code,
    String? shortCode,
    bool? status,
  }) => Data(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    shortCode: shortCode ?? this.shortCode,
    status: status ?? this.status,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['short_code'] = shortCode;
    map['status'] = status;
    return map;
  }
}
