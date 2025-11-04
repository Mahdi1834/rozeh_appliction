part of 'profile_bloc.dart';


@immutable
abstract class UpdateProfileStatus{}

class UpdateProfileStatusInit extends UpdateProfileStatus{}
class UpdateProfileStatusLoading extends UpdateProfileStatus{}
class UpdateProfileStatusCompleted extends UpdateProfileStatus{
  final UpdateProfileModel updateProfileModel;

  UpdateProfileStatusCompleted(this.updateProfileModel);

}
class UpdateProfileStatusError extends UpdateProfileStatus{
  final String? message;

  UpdateProfileStatusError(this.message);

}