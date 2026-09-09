import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rozeh_project/core/config/theme/data/model/theme_model.dart';
import 'package:rozeh_project/core/config/theme/data/repository/theme_repository.dart';

import 'package:rozeh_project/core/resources/data_state.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepository repository;

  ThemeCubit(this.repository) : super(const ThemeState());

  void setThemeMode(ThemeMode mode) {
    emit(
      state.copyWith(
        themeMode: mode,
        status: ThemeStatus.success,
        errorMessage: null,
      ),
    );
  }

  void toggleTheme() {
    final nextMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;

    emit(
      state.copyWith(
        themeMode: nextMode,
        status: ThemeStatus.success,
        errorMessage: null,
      ),
    );
  }

  Future<void> loadTheme() async {
    emit(state.copyWith(status: ThemeStatus.loading, errorMessage: null));

    final DataState<ThemeModel> result = await repository.getTheme();

    if (result is DataSuccess<ThemeModel>) {
      final ThemeModel? themeModel = result.data;

      final String? serverTheme = themeModel?.data?.theme?.toLowerCase();

      switch (serverTheme) {
        case 'dark':
          emit(
            state.copyWith(
              themeMode: ThemeMode.dark,
              status: ThemeStatus.success,
              errorMessage: null,
            ),
          );
          break;

        case 'light':
          emit(
            state.copyWith(
              themeMode: ThemeMode.light,
              status: ThemeStatus.success,
              errorMessage: null,
            ),
          );
          break;

        default:
          // اگر سرور مقدار نامعتبر فرستاد
          // Light به عنوان حالت پیش‌فرض
          emit(
            state.copyWith(
              themeMode: ThemeMode.light,
              status: ThemeStatus.success,
              errorMessage: null,
            ),
          );
          break;
      }

      return;
    }

    // در صورت خطا
    emit(
      state.copyWith(
        themeMode: ThemeMode.light,
        status: ThemeStatus.failure,
        errorMessage: result.error,
      ),
    );
  }
}
