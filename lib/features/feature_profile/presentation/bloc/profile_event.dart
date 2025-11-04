part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetProvincesEvent extends ProfileEvent {}

class GetCustomerInfoEvent extends ProfileEvent{}


class GetCitiesEvent extends ProfileEvent {
  final String provinceId;

  GetCitiesEvent({required this.provinceId});
}

class UpdateProfileEvent extends ProfileEvent {
  final ProfileModelForSend profileModelForSend;

  UpdateProfileEvent({required this.profileModelForSend});
}
