

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rozeh_project/core/config/constants.dart';

class LoginApiProvider{
  Dio dio;

  LoginApiProvider(this.dio);

  dynamic callSendVerificationCode(String mobile) async {
    Map<String, dynamic> data = {
      'mobile': mobile,
      'type' : "mobile",

    };


    final response = await dio.post("${Constants.baseUrl}/verification-code",
        data: jsonEncode(data),
        options: Options(
          headers: {
            "Accept": "application/json",
          },
        )

    );
    print(response.toString());
    return response;
  }

  dynamic callVerifyCode({required String mobile , required String code ,required String deviceName}) async {
    Map<String, dynamic> data = {
      'mobile': mobile,
      'type' : "mobile",
      'code' : code,
      'device_name' : deviceName,

    };


    final response = await dio.post("${Constants.baseUrl}/verify-code",
        data: jsonEncode(data),
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