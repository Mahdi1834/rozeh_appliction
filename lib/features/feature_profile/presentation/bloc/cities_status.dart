part of 'profile_bloc.dart';

@immutable
abstract class CitiesStatus {}

class CitiesStatusInit extends CitiesStatus {}

class CitiesStatusLoading extends CitiesStatus {}

class CitiesStatusCompleted extends CitiesStatus {
  final CitiesModel citiesModel;

  CitiesStatusCompleted(this.citiesModel);
}

class CitiesStatusError extends CitiesStatus {
  final String? message;

  CitiesStatusError(this.message);
}
