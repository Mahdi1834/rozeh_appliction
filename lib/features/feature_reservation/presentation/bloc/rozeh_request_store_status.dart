part of 'reservation_bloc.dart';


@immutable
abstract class RozehRequestStoreStatus{}

class RozehRequestStoreStatusInit extends RozehRequestStoreStatus{}
class RozehRequestStoreStatusLoading extends RozehRequestStoreStatus{}
class RozehRequestStoreStatusCompleted extends RozehRequestStoreStatus{
  final RozehRequestStoreModel rozehRequestStoreModel;

  RozehRequestStoreStatusCompleted(this.rozehRequestStoreModel);

}
class RozehRequestStoreStatusError extends RozehRequestStoreStatus{
  final String? message;

  RozehRequestStoreStatusError(this.message);

}