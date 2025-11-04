part of 'profile_bloc.dart';


@immutable
abstract class ProvincesStatus{}

class ProvincesStatusInit extends ProvincesStatus{}
class ProvincesStatusLoading extends ProvincesStatus{}
class ProvincesStatusCompleted extends ProvincesStatus{
  final ProvincesModel provincesModel;

  ProvincesStatusCompleted(this.provincesModel);

}
class ProvincesStatusError extends ProvincesStatus{
  final String? message;

  ProvincesStatusError(this.message);

}