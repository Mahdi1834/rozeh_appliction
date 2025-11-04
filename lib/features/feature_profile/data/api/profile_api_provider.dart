import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_profile/data/model/profile_model_for_send.dart';
import 'package:rozeh_project/locator.dart';

class ProfileApiProvider {
  Dio dio;

  ProfileApiProvider(this.dio);

  dynamic callGetProvinces() async {
    final response = await dio.get(
      "${Constants.baseUrl}/public/provinces",

      options: Options(headers: {"Accept": "application/json"}),
    );

    return response;
  }

  dynamic callGetCities({required String provinceId}) async {
    final response = await dio.get(
      "${Constants.baseUrl}/public/cities",
      queryParameters: {
        "province_id": provinceId, // 👈 پارامتر ارسالی به سرور
      },

      options: Options(headers: {"Accept": "application/json"}),
    );

    return response;
  }

  dynamic callGetCustomer() async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final response = await dio.get(
      "${Constants.baseUrl}/customer/show",

      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }

  dynamic callUpdateProfile({
    required ProfileModelForSend profileModelForSend,
  }) async {
    UserSession userSession = locator();

    String? token = await userSession.getToken();

    final Map<String, dynamic> data = {
      "full_name": profileModelForSend.fullName,
      if (profileModelForSend.nationalCode != null)
        "national_code": profileModelForSend.nationalCode,
      "address": profileModelForSend.address,
      "province_id": profileModelForSend.provinceId,
      "city_id": profileModelForSend.cityId,
    };

    final response = await dio.post(
      "${Constants.baseUrl}/customer/profile",
      data: data,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    return response;
  }
}
