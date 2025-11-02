import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_home/data/api/home_api_provider.dart';
import 'package:rozeh_project/features/feature_home/data/model/current_hadith_model.dart';


class HomeRepository {
  HomeApiProvider apiProvider;

  HomeRepository(this.apiProvider);

  Future<DataState<CurrentHadithModel>> fetchCurrentHadith() async {
    try {
      Response response = await apiProvider.callGetCurrentHadith();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final CurrentHadithModel currentHadithModel = CurrentHadithModel.fromJson(response.data);
        return DataSuccess(currentHadithModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }



}
