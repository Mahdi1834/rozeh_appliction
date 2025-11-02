part of 'login_bloc.dart';


@immutable
abstract class VerifyCodeStatus{}

class VerifyCodeStatusInit extends VerifyCodeStatus{}
class VerifyCodeStatusLoading extends VerifyCodeStatus{}
class VerifyCodeStatusCompleted extends VerifyCodeStatus{
  final VerifyCodeModel verifyCodeModel;

  VerifyCodeStatusCompleted(this.verifyCodeModel);

}
class VerifyCodeStatusError extends VerifyCodeStatus{
  final String? message;

  VerifyCodeStatusError(this.message);

}