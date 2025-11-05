part of 'reservation_bloc.dart';


@immutable
abstract class AgeGroupStatus{}

class AgeGroupStatusInit extends AgeGroupStatus{}
class AgeGroupStatusLoading extends AgeGroupStatus{}
class AgeGroupStatusCompleted extends AgeGroupStatus{
  final AgeGroupModel ageGroupModel;

  AgeGroupStatusCompleted(this.ageGroupModel);

}
class AgeGroupStatusError extends AgeGroupStatus{
  final String? message;

  AgeGroupStatusError(this.message);

}