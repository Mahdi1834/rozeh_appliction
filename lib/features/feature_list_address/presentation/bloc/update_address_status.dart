part of 'address_bloc.dart';



@immutable
abstract class UpdateAddressStatus{}

class UpdateAddressStatusInit extends UpdateAddressStatus{}
class UpdateAddressStatusLoading extends UpdateAddressStatus{}
class UpdateAddressStatusCompleted extends UpdateAddressStatus{
  final StoreAddressModel updateAddressModel;

  UpdateAddressStatusCompleted(this.updateAddressModel);

}
class UpdateAddressStatusError extends UpdateAddressStatus{
  final String? message;

  UpdateAddressStatusError(this.message);

}