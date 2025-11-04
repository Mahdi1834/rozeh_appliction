import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';


import 'package:rozeh_project/features/feature_profile/data/api/profile_api_provider.dart';
import 'package:rozeh_project/features/feature_profile/data/model/cities_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/profile_model_for_send.dart';
import 'package:rozeh_project/features/feature_profile/data/model/provinces_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/update_profile_model.dart';


class ProfileRepository {
  ProfileApiProvider apiProvider;

  ProfileRepository(this.apiProvider);

  Future<DataState<ProvincesModel>> fetchProvinces() async {
    try {
      Response response = await apiProvider.callGetProvinces();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final ProvincesModel provincesModel = ProvincesModel.fromJson(response.data);
        return DataSuccess(provincesModel);
      } else {
        return DataFailed("خطا در  دریافت استان ها !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<CitiesModel>> fetchCities({required String provinceId}) async {
    try {
      Response response = await apiProvider.callGetCities(provinceId: provinceId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final CitiesModel citiesModel = CitiesModel.fromJson(response.data);
        return DataSuccess(citiesModel);
      } else {
        return DataFailed("خطا در  دریافت شهرها !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<UpdateProfileModel>> fetchUpdateProfile({required ProfileModelForSend profileModelForSend}) async {
    try {
      Response response = await apiProvider.callUpdateProfile(profileModelForSend: profileModelForSend);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final UpdateProfileModel updateProfileModel = UpdateProfileModel.fromJson(response.data);
        return DataSuccess(updateProfileModel);
      } else {
        return DataFailed("خطا در  دریافت شهرها !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }






}
