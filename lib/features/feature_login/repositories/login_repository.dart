import 'package:dio/dio.dart';
import 'package:rozeh_project/core/error_handling/get_message.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_login/data/api/login_api_provider.dart';
import 'package:rozeh_project/features/feature_login/data/model/login_model.dart';
import 'package:rozeh_project/features/feature_login/data/model/verify_code_model.dart';

class LoginRepository {
  LoginApiProvider apiProvider;

  LoginRepository(this.apiProvider);

  Future<DataState<LoginModel>> fetchSendVerification(String mobile) async {
    try {
      Response response = await apiProvider.callSendVerificationCode(mobile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final LoginModel homeModel = LoginModel.fromJson(response.data);
        return DataSuccess(homeModel);
      } else {
        return DataFailed("خطا در ارسال پیامک !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }

  Future<DataState<VerifyCodeModel>> fetchVerifyCode({
    required String mobile,
    required String code,
    required String deviceName,
  }) async {
    try {
      Response response = await apiProvider.callVerifyCode(
        code: code,
        deviceName: deviceName,
        mobile: mobile,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final VerifyCodeModel verifyCodeModel = VerifyCodeModel.fromJson(response.data);
        return DataSuccess(verifyCodeModel);
      } else {
        return DataFailed("خطا در تایید کد !!!");
      }
    } on DioException catch (e) {
      return DataFailed(getMessage(e));
    }
  }
}
