part of "niyabat_bloc.dart";



@immutable
abstract class UpdateNiyabatStatus{}

class UpdateNiyabatStatusInit extends UpdateNiyabatStatus{}
class UpdateNiyabatStatusLoading extends UpdateNiyabatStatus{}
class UpdateNiyabatStatusCompleted extends UpdateNiyabatStatus{
  final UpdateNiyabatModel updateNiyabatModel;

  UpdateNiyabatStatusCompleted(this.updateNiyabatModel);

}
class UpdateNiyabatStatusError extends UpdateNiyabatStatus{
  final String? message;

  UpdateNiyabatStatusError(this.message);

}