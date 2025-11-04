part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final ProvincesStatus provincesStatus;
  final CitiesStatus citiesStatus;
  final UpdateProfileStatus updateProfileStatus;

  const ProfileState({
    required this.provincesStatus,
    required this.citiesStatus,
    required this.updateProfileStatus,
  });

  ProfileState copyWith({
    ProvincesStatus? newProvincesStatus,
    CitiesStatus? newCitiesStatus,
    UpdateProfileStatus? newUpdateProfileStatus,
  }) {
    return ProfileState(
      updateProfileStatus: newUpdateProfileStatus ?? updateProfileStatus,
      provincesStatus: newProvincesStatus ?? provincesStatus,
      citiesStatus: newCitiesStatus ?? citiesStatus,
    );
  }
}
