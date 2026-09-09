import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';

class ThemeApiProvider {
  final Dio dio;

  ThemeApiProvider(this.dio);

  Future<Response> getTheme() {
    return dio.get(
      "${Constants.baseUrl}/public/theme",
      options: Options(
        headers: {
          "Accept": "application/json",
        },
      ),
    );
  }
}