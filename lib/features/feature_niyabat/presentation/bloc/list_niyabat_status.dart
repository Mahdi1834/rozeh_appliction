part of 'niyabat_bloc.dart';




@immutable
abstract class ListNiyabatStatus{}

class ListNiyabatStatusInit extends ListNiyabatStatus{}
class ListNiyabatStatusLoading extends ListNiyabatStatus{}
class ListNiyabatStatusCompleted extends ListNiyabatStatus{
  final ListNiyabatModel listNiyabatModel;

  ListNiyabatStatusCompleted(this.listNiyabatModel);

}
class ListNiyabatStatusError extends ListNiyabatStatus{
  final String? message;

  ListNiyabatStatusError(this.message);

}