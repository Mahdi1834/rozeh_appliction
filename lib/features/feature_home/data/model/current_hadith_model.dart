/// success : true
/// message : " حدیث با موفقیت ارسال شد"
/// data : {"current_hadith":{"id":1,"content_ar":"«حَمَلَةُ القُرْآنِ هُمُ المَحْفُوفونَ بِرَحمَةِ اللهِ، المُلَبِّسونَ نُورَ اللهِ، المُعَلِّمونَ كَلامَ اللهِ مَنْ عاداهُم فَقَدْ عادَی اللهَ و مَنْ والاهُم فَقَدْ والَی اللهَ»","content_fa":"حافظان قرآن مشمول رحمت خدا، در بركنندگان نور خدا و آموزگاران كلام خدایند. كسی كه با آنان دوستی نماید باخدادوستی نموده است.","source":"(مستدرك الوسائل /ج۴/ص ۲۵۴)","author":"قال رسول الله (صلی الله علیه و آله و سلم)","created_at":"2025-11-02T12:22:26.000000Z","updated_at":"2025-11-02T12:22:26.000000Z","deleted_at":null}}

class CurrentHadithModel {
  CurrentHadithModel({this.success, this.message, this.data});

  CurrentHadithModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  CurrentHadithModel copyWith({bool? success, String? message, Data? data}) =>
      CurrentHadithModel(
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

/// current_hadith : {"id":1,"content_ar":"«حَمَلَةُ القُرْآنِ هُمُ المَحْفُوفونَ بِرَحمَةِ اللهِ، المُلَبِّسونَ نُورَ اللهِ، المُعَلِّمونَ كَلامَ اللهِ مَنْ عاداهُم فَقَدْ عادَی اللهَ و مَنْ والاهُم فَقَدْ والَی اللهَ»","content_fa":"حافظان قرآن مشمول رحمت خدا، در بركنندگان نور خدا و آموزگاران كلام خدایند. كسی كه با آنان دوستی نماید باخدادوستی نموده است.","source":"(مستدرك الوسائل /ج۴/ص ۲۵۴)","author":"قال رسول الله (صلی الله علیه و آله و سلم)","created_at":"2025-11-02T12:22:26.000000Z","updated_at":"2025-11-02T12:22:26.000000Z","deleted_at":null}

class Data {
  Data({this.currentHadith});

  Data.fromJson(dynamic json) {
    currentHadith =
        json['current_hadith'] != null
            ? CurrentHadith.fromJson(json['current_hadith'])
            : null;
  }

  CurrentHadith? currentHadith;

  Data copyWith({CurrentHadith? currentHadith}) =>
      Data(currentHadith: currentHadith ?? this.currentHadith);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (currentHadith != null) {
      map['current_hadith'] = currentHadith?.toJson();
    }
    return map;
  }
}

/// id : 1
/// content_ar : "«حَمَلَةُ القُرْآنِ هُمُ المَحْفُوفونَ بِرَحمَةِ اللهِ، المُلَبِّسونَ نُورَ اللهِ، المُعَلِّمونَ كَلامَ اللهِ مَنْ عاداهُم فَقَدْ عادَی اللهَ و مَنْ والاهُم فَقَدْ والَی اللهَ»"
/// content_fa : "حافظان قرآن مشمول رحمت خدا، در بركنندگان نور خدا و آموزگاران كلام خدایند. كسی كه با آنان دوستی نماید باخدادوستی نموده است."
/// source : "(مستدرك الوسائل /ج۴/ص ۲۵۴)"
/// author : "قال رسول الله (صلی الله علیه و آله و سلم)"
/// created_at : "2025-11-02T12:22:26.000000Z"
/// updated_at : "2025-11-02T12:22:26.000000Z"
/// deleted_at : null

class CurrentHadith {
  CurrentHadith({
    this.id,
    this.contentAr,
    this.contentFa,
    this.source,
    this.author,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  CurrentHadith.fromJson(dynamic json) {
    id = json['id'];
    contentAr = json['content_ar'];
    contentFa = json['content_fa'];
    source = json['source'];
    author = json['author'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? contentAr;
  String? contentFa;
  String? source;
  String? author;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  CurrentHadith copyWith({
    num? id,
    String? contentAr,
    String? contentFa,
    String? source,
    String? author,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) => CurrentHadith(
    id: id ?? this.id,
    contentAr: contentAr ?? this.contentAr,
    contentFa: contentFa ?? this.contentFa,
    source: source ?? this.source,
    author: author ?? this.author,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt ?? this.deletedAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content_ar'] = contentAr;
    map['content_fa'] = contentFa;
    map['source'] = source;
    map['author'] = author;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}
