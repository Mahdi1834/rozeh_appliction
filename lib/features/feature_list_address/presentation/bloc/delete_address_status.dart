part of 'address_bloc.dart';

@immutable
abstract class DeleteAddressStatus {}

class DeleteAddressStatusInit extends DeleteAddressStatus {}

class DeleteAddressStatusLoading extends DeleteAddressStatus {}

class DeleteAddressStatusCompleted extends DeleteAddressStatus {
  final DeleteAddressModel deleteAddressModel;

  DeleteAddressStatusCompleted(this.deleteAddressModel);
}

class DeleteAddressStatusError extends DeleteAddressStatus {
  final String? message;

  DeleteAddressStatusError(this.message);
}
