part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class SendVerificationCodeEvent extends LoginEvent {
  final String mobile;

  SendVerificationCodeEvent({required this.mobile});
}

class VerifyCodeEvent extends LoginEvent {
  final String mobile;
  final String code;
  final String deviceName;

  VerifyCodeEvent({
    required this.mobile,
    required this.code,
    required this.deviceName,
  });
}
