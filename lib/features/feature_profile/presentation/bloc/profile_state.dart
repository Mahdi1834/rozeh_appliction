part of 'profile_bloc.dart';

@immutable
class ProfileState {
  final ProvincesStatus provincesStatus;
  final CitiesStatus citiesStatus;
  final UpdateProfileStatus updateProfileStatus;
  final CustomerInfoStatus customerInfoStatus;

  const ProfileState({
    required this.provincesStatus,
    required this.citiesStatus,
    required this.updateProfileStatus,
    required this.customerInfoStatus,
  });

  ProfileState copyWith({
    ProvincesStatus? newProvincesStatus,
    CitiesStatus? newCitiesStatus,
    UpdateProfileStatus? newUpdateProfileStatus,
    CustomerInfoStatus? newCustomerInfoStatus,
  }) {
    return ProfileState(
      updateProfileStatus: newUpdateProfileStatus ?? updateProfileStatus,
      provincesStatus: newProvincesStatus ?? provincesStatus,
      citiesStatus: newCitiesStatus ?? citiesStatus,
      customerInfoStatus: newCustomerInfoStatus ?? customerInfoStatus,
    );
  }
}
