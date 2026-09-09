class ThemeModel {
  final bool? success;
  final String? message;
  final ThemeDataModel? data;

  const ThemeModel({
    this.success,
    this.message,
    this.data,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ThemeDataModel.fromJson(
        Map<String, dynamic>.from(json['data']),
      )
          : null,
    );
  }

  ThemeModel copyWith({
    bool? success,
    String? message,
    ThemeDataModel? data,
  }) {
    return ThemeModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ThemeDataModel {
  final String? theme;

  const ThemeDataModel({
    this.theme,
  });

  factory ThemeDataModel.fromJson(Map<String, dynamic> json) {
    return ThemeDataModel(
      theme: json['theme'] as String?,
    );
  }

  ThemeDataModel copyWith({
    String? theme,
  }) {
    return ThemeDataModel(
      theme: theme ?? this.theme,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme': theme,
    };
  }
}