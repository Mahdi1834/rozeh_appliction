class MaddahModel {
  MaddahModel({
    this.success,
    this.message,
    this.data,
  });

  MaddahModel.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  MaddahModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return MaddahModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['success'] = success;
    map['message'] = message;

    if (data != null) {
      map['data'] = data!.toJson();
    }

    return map;
  }
}


/// data : {
///   "users": [
///     {
///       "id": 3,
///       "is_speaker": true,
///       "is_maddah": true,
///       "full_name": "maddah",
///       "assignment_label": "سخنران و مداح",
///       "assignment_display": "maddah (سخنران و مداح)"
///     }
///   ]
/// }

class Data {
  Data({
    this.users,
  });

  Data.fromJson(dynamic json) {
    if (json['users'] != null) {
      users = [];

      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }
  }

  List<User>? users;

  Data copyWith({
    List<User>? users,
  }) {
    return Data(
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (users != null) {
      map['users'] = users!.map((v) => v.toJson()).toList();
    }

    return map;
  }
}


/// id : 3
/// is_speaker : true
/// is_maddah : true
/// full_name : "maddah"
/// assignment_label : "سخنران و مداح"
/// assignment_display : "maddah (سخنران و مداح)"

class User {
  User({
    this.id,
    this.isSpeaker,
    this.isMaddah,
    this.fullName,
    this.assignmentLabel,
    this.assignmentDisplay,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    isSpeaker = json['is_speaker'];
    isMaddah = json['is_maddah'];
    fullName = json['full_name'];
    assignmentLabel = json['assignment_label'];
    assignmentDisplay = json['assignment_display'];
  }

  int? id;
  bool? isSpeaker;
  bool? isMaddah;
  String? fullName;
  String? assignmentLabel;
  String? assignmentDisplay;

  User copyWith({
    int? id,
    bool? isSpeaker,
    bool? isMaddah,
    String? fullName,
    String? assignmentLabel,
    String? assignmentDisplay,
  }) {
    return User(
      id: id ?? this.id,
      isSpeaker: isSpeaker ?? this.isSpeaker,
      isMaddah: isMaddah ?? this.isMaddah,
      fullName: fullName ?? this.fullName,
      assignmentLabel: assignmentLabel ?? this.assignmentLabel,
      assignmentDisplay: assignmentDisplay ?? this.assignmentDisplay,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['id'] = id;
    map['is_speaker'] = isSpeaker;
    map['is_maddah'] = isMaddah;
    map['full_name'] = fullName;
    map['assignment_label'] = assignmentLabel;
    map['assignment_display'] = assignmentDisplay;

    return map;
  }
}