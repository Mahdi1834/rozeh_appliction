
import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_send_model.dart';
import 'package:rozeh_project/locator.dart';

class ReservationApiProvider{
  Dio dio;

  ReservationApiProvider(this.dio);

  dynamic callGetAgeGroup() async {

    final response = await dio.get("${Constants.baseUrl}/public/ageGroup",

        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );

    return response;
  }


  dynamic callGetMaddah() async {

    final response = await dio.get("${Constants.baseUrl}/public/users/maddah",

        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );

    return response;
  }


  dynamic callGetSpeaker() async {

    final response = await dio.get("${Constants.baseUrl}/public/users/speaker",

        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );

    return response;
  }

  dynamic callGetRozehType() async {

    final response = await dio.get("${Constants.baseUrl}/public/rozeh",

        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );

    return response;
  }






  dynamic callGetRozehRequestStore({required RozehRequestSendModel rozehRequestSendModel}) async {

    UserSession userSession = locator();

    String? token = await userSession.getToken();
    final response = await dio.post("${Constants.baseUrl}/rozehRequest/store",
        data: rozehRequestSendModel.toJson(),
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        )

    );


    return response;
  }


}