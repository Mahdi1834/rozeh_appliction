part of "niyabat_bloc.dart";


@immutable
abstract class DeleteNiyabatStatus{}

class DeleteNiyabatStatusInit extends DeleteNiyabatStatus{}
class DeleteNiyabatStatusLoading extends DeleteNiyabatStatus{}
class DeleteNiyabatStatusCompleted extends DeleteNiyabatStatus{
  final DeleteNiyabatModel deleteNiyabatModel;

  DeleteNiyabatStatusCompleted(this.deleteNiyabatModel);

}
class DeleteNiyabatStatusError extends DeleteNiyabatStatus{
  final String? message;

  DeleteNiyabatStatusError(this.message);

}