part of 'login_bloc.dart';

@immutable
class LoginState {
  final LoginVerificationStatus loginVerificationStatusStatus;
  final VerifyCodeStatus verifyCodeStatus;

  const LoginState({
    required this.loginVerificationStatusStatus,
    required this.verifyCodeStatus,
  });

  LoginState copyWith({
    LoginVerificationStatus? newLoginVerificationStatusStatus,
    VerifyCodeStatus? newVerifyCodeStatus,
  }) {
    return LoginState(
      loginVerificationStatusStatus:
          newLoginVerificationStatusStatus ?? loginVerificationStatusStatus,
      verifyCodeStatus: newVerifyCodeStatus ?? verifyCodeStatus,
    );
  }
}
