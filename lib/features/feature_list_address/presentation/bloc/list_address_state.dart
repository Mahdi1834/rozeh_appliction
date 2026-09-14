part of 'address_bloc.dart';



@immutable
abstract class ListAddressStatus{}

class ListAddressStatusInit extends ListAddressStatus{}
class ListAddressStatusLoading extends ListAddressStatus{}
class ListAddressStatusCompleted extends ListAddressStatus{
  final ListAddressModel listAddressModel;

  ListAddressStatusCompleted(this.listAddressModel);

}
class ListAddressStatusError extends ListAddressStatus{
  final String? message;

  ListAddressStatusError(this.message);

}