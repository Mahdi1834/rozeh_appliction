
import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';

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
    print(response.toString());
    return response;
  }


}