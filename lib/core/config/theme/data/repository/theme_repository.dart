import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/theme/data/api/theme_api_provider.dart';
import 'package:rozeh_project/core/config/theme/data/model/theme_model.dart';

import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';


class ThemeRepository {
  final ThemeApiProvider apiProvider;

  ThemeRepository(this.apiProvider);

  Future<DataState<ThemeModel>> getTheme() async {
    try {
      final response = await apiProvider.getTheme();

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final themeModel = ThemeModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );

        if (themeModel.success != true) {
          return DataFailed(
            themeModel.message ?? 'خطا در دریافت تم برنامه',
          );
        }

        return DataSuccess(themeModel);
      }

      return const DataFailed(
        'خطا در دریافت تم برنامه',
      );
    } on DioException catch (e) {
      return DataFailed(
        getMessage(e),
      );
    } catch (e) {
      return const DataFailed(
        'خطای نامشخص در دریافت تم برنامه',
      );
    }
  }
}