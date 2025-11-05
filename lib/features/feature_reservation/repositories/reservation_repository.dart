import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_reservation/data/api/reservation_api_provider.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/age_group_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/maddah_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_send_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_store_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_type_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/speaker_model.dart';

class ReservationRepository {
  ReservationApiProvider apiProvider;

  ReservationRepository(this.apiProvider);

  Future<DataState<AgeGroupModel>> fetchAgeGroup() async {
    try {
      Response response = await apiProvider.callGetAgeGroup();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final AgeGroupModel ageGroupModel = AgeGroupModel.fromJson(
          response.data,
        );
        return DataSuccess(ageGroupModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<MaddahModel>> fetchMaddah() async {
    try {
      Response response = await apiProvider.callGetMaddah();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final MaddahModel maddahModel = MaddahModel.fromJson(response.data);
        return DataSuccess(maddahModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<SpeakerModel>> fetchSpeaker() async {
    try {
      Response response = await apiProvider.callGetSpeaker();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final SpeakerModel speakerModel = SpeakerModel.fromJson(response.data);
        return DataSuccess(speakerModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<RozehTypeModel>> fetchRozehType() async {
    try {
      Response response = await apiProvider.callGetRozehType();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final RozehTypeModel rozehTypeModel = RozehTypeModel.fromJson(
          response.data,
        );
        return DataSuccess(rozehTypeModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<RozehRequestStoreModel>> fetchRozehRequestStore({
    required RozehRequestSendModel rozehRequestSendModel,
  }) async {
    try {
      Response response = await apiProvider.callGetRozehRequestStore(
        rozehRequestSendModel: rozehRequestSendModel,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final RozehRequestStoreModel rozehRequestStoreModel =
            RozehRequestStoreModel.fromJson(response.data);
        return DataSuccess(rozehRequestStoreModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }
}
