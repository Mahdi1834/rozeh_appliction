import 'package:dio/dio.dart';

String getMessage(DioException e) {
  final res = e.response;
  final data = res?.data;

  switch (res?.statusCode) {
    case 400:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "درخواست نامعتبر بود.";

    case 401:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "توکن شما منقضی شده است، لطفاً دوباره وارد شوید.";

    case 403:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "شما مجاز به انجام این عملیات نیستید.";

    case 404:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "آدرس مورد نظر یافت نشد.";

    case 422:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "داده‌های ارسال‌شده نامعتبر هستند.";

    case 410:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "کد اشتباه است یا زمان آن تمام شده است.";

    case 500:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "خطایی در سرور رخ داده است.";

    default:
      return data is Map<String, dynamic> && data['message'] != null
          ? data['message'].toString()
          : "خطا هنگام دریافت اطلاعات از سرور رخ داد.";
  }
}
