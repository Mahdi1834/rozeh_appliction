part of 'login_bloc.dart';


@immutable
abstract class LoginVerificationStatus{}

class LoginVerificationStatusInit extends LoginVerificationStatus{}
class LoginVerificationStatusLoading extends LoginVerificationStatus{}
class LoginVerificationStatusCompleted extends LoginVerificationStatus{
  final LoginModel loginModel;

  LoginVerificationStatusCompleted(this.loginModel);

}
class LoginVerificationStatusError extends LoginVerificationStatus{
  final String? message;

  LoginVerificationStatusError(this.message);

}