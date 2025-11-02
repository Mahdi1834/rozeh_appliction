import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_login/data/model/login_model.dart';
import 'package:rozeh_project/features/feature_login/data/model/verify_code_model.dart';
import 'package:rozeh_project/features/feature_login/repositories/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_verification_status.dart';

part 'verify_code_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository;

  LoginBloc(this.loginRepository)
    : super(
        LoginState(
          loginVerificationStatusStatus: LoginVerificationStatusInit(),
          verifyCodeStatus: VerifyCodeStatusInit(),
        ),
      ) {
    on<SendVerificationCodeEvent>((event, emit) async {
      // TODO: implement event handler
      emit(
        state.copyWith(
          newLoginVerificationStatusStatus: LoginVerificationStatusLoading(),
        ),
      );
      DataState dataState = await loginRepository.fetchSendVerification(
        event.mobile,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newLoginVerificationStatusStatus: LoginVerificationStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newLoginVerificationStatusStatus: LoginVerificationStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });

    on<VerifyCodeEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newVerifyCodeStatus: VerifyCodeStatusLoading()));
      DataState dataState = await loginRepository.fetchVerifyCode(
        mobile: event.mobile,
        code: event.code,
        deviceName: event.deviceName,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newVerifyCodeStatus: VerifyCodeStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newVerifyCodeStatus: VerifyCodeStatusError(dataState.error!),
          ),
        );
      }
    });
  }
}
