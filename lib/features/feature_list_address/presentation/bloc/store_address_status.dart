part of 'address_bloc.dart';



@immutable
abstract class StoreAddressStatus{}

class StoreAddressStatusInit extends StoreAddressStatus{}
class StoreAddressStatusLoading extends StoreAddressStatus{}
class StoreAddressStatusCompleted extends StoreAddressStatus{
  final StoreAddressModel storeAddressModel;

  StoreAddressStatusCompleted(this.storeAddressModel);

}
class StoreAddressStatusError extends StoreAddressStatus{
  final String? message;

  StoreAddressStatusError(this.message);

}