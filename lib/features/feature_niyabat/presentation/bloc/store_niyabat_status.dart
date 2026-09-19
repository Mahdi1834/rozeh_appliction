part of "niyabat_bloc.dart";


@immutable
abstract class StoreNiyabatStatus{}

class StoreNiyabatStatusInit extends StoreNiyabatStatus{}
class StoreNiyabatStatusLoading extends StoreNiyabatStatus{}
class StoreNiyabatStatusCompleted extends StoreNiyabatStatus{
  final StoreNiyabatModel storeNiyabatModel;

  StoreNiyabatStatusCompleted(this.storeNiyabatModel);

}
class StoreNiyabatStatusError extends StoreNiyabatStatus{
  final String? message;

  StoreNiyabatStatusError(this.message);

}