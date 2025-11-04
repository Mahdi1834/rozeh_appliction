import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_profile/data/model/cities_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/profile_model_for_send.dart';
import 'package:rozeh_project/features/feature_profile/data/model/provinces_model.dart';
import 'package:rozeh_project/features/feature_profile/data/model/update_profile_model.dart';
import 'package:rozeh_project/features/feature_profile/repositories/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'provinces_status.dart';

part 'cities_status.dart';

part 'update_profile_status.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository)
    : super(
        ProfileState(
          provincesStatus: ProvincesStatusInit(),
          citiesStatus: CitiesStatusInit(),
          updateProfileStatus: UpdateProfileStatusInit(),
        ),
      ) {
    on<GetProvincesEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newProvincesStatus: ProvincesStatusLoading()));
      DataState dataState = await profileRepository.fetchProvinces();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newProvincesStatus: ProvincesStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newProvincesStatus: ProvincesStatusError(dataState.error!),
          ),
        );
      }
    });

    on<GetCitiesEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newCitiesStatus: CitiesStatusLoading()));

      DataState dataState = await profileRepository.fetchCities(
        provinceId: event.provinceId,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newCitiesStatus: CitiesStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(newCitiesStatus: CitiesStatusError(dataState.error!)),
        );
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      // TODO: implement event handler
      emit(
        state.copyWith(newUpdateProfileStatus: UpdateProfileStatusLoading()),
      );

      DataState dataState = await profileRepository.fetchUpdateProfile(
        profileModelForSend: event.profileModelForSend,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newUpdateProfileStatus: UpdateProfileStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newUpdateProfileStatus: UpdateProfileStatusError(dataState.error!),
          ),
        );
      }
    });
  }
}
