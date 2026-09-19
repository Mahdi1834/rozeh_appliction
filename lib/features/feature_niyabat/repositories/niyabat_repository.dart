import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_niyabat/data/api/niyabat_api_provider.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/intentions_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/niyabat_model_for_send.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/delete_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/store_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/tavaslats_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/update_niyabat_model.dart';

class NiyabatRepository {
  final NiyabatApiProvider apiProvider;

  NiyabatRepository(this.apiProvider);

  // ============================================================
  // Get Tavaslats
  // ============================================================

  Future<DataState<TavaslatsModel>> fetchTavaslats() async {
    try {
      final Response response = await apiProvider.callGetTavaslats();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final TavaslatsModel tavaslatsModel = TavaslatsModel.fromJson(
          response.data,
        );

        return DataSuccess(tavaslatsModel);
      }

      return DataFailed("خطا در دریافت توسل ها !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Get Intentions
  // ============================================================

  Future<DataState<IntentionsModel>> fetchIntentions() async {
    try {
      final Response response = await apiProvider.callGetIntention();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final IntentionsModel intentionsModel = IntentionsModel.fromJson(
          response.data,
        );

        return DataSuccess(intentionsModel);
      }

      return DataFailed("خطا در دریافت نیت ها !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Get Niyabats
  // ============================================================

  Future<DataState<ListNiyabatModel>> fetchNiyabats({int page = 1}) async {
    try {
      final Response response = await apiProvider.callGetListNiyabat(
        page: page,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final ListNiyabatModel listNiyabatModel = ListNiyabatModel.fromJson(
          response.data,
        );

        return DataSuccess(listNiyabatModel);
      }

      return DataFailed("خطا در دریافت لیست نیابت ها !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Create Niyabat
  // ============================================================

  Future<DataState<StoreNiyabatModel>> createNiyabat({
    required NiyabatModelForSend niyabatModelForSend,
  }) async {
    try {
      final Response response = await apiProvider.callCreateNiyabat(
        niyabatModelForSend: niyabatModelForSend,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final StoreNiyabatModel storeNiyabatModel = StoreNiyabatModel.fromJson(
          response.data,
        );

        return DataSuccess(storeNiyabatModel);
      }

      return DataFailed("خطا در ثبت نیابت !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Update Niyabat
  // ============================================================

  Future<DataState<UpdateNiyabatModel>> updateNiyabat({
    required int niyabatId,
    required NiyabatModelForSend niyabatModelForSend,
  }) async {
    try {
      final Response response = await apiProvider.callUpdateNiyabat(
        niyabatId: niyabatId,
        niyabatModelForSend: niyabatModelForSend,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UpdateNiyabatModel updateNiyabatModel =
            UpdateNiyabatModel.fromJson(response.data);

        return DataSuccess(updateNiyabatModel);
      }

      return DataFailed("خطا در ویرایش نیابت !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  // ============================================================
  // Delete Niyabat
  // ============================================================

  Future<DataState<DeleteNiyabatModel>> deleteNiyabat({
    required int niyabatId,
  }) async {
    try {
      final Response response = await apiProvider.callDeleteNiyabat(
        niyabatId: niyabatId,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final DeleteNiyabatModel deleteNiyabatModel =
            DeleteNiyabatModel.fromJson(response.data);

        return DataSuccess(deleteNiyabatModel);
      }

      return DataFailed("خطا در حذف نیابت !!!");
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }
}
