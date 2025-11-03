
import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/locator.dart';

class HomeApiProvider{
  Dio dio;

  HomeApiProvider(this.dio);

  dynamic callGetCurrentHadith() async {

    final response = await dio.get("${Constants.baseUrl}/public/hadith/current",

        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );

    return response;
  }


  dynamic callGetRozehRequest({required String page , String? query}) async {
    final params = <String, dynamic>{
      'page': page,
      if (query != null && query.trim().isNotEmpty) 'query': query.trim(),
    };
    UserSession userSession = locator();

    String? token = await userSession.getToken();
    final response = await dio.get("${Constants.baseUrl}/rozehRequest",
        queryParameters: params,
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