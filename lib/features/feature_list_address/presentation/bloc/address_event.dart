part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}


// ============================================================
// List
// ============================================================

class ListAddressEvent extends AddressEvent {}


// ============================================================
// Store
// ============================================================

class StoreAddressEvent extends AddressEvent {
  final CustomerAddressModelForSend addressModel;

  StoreAddressEvent({
    required this.addressModel,
  });
}


// ============================================================
// Update
// ============================================================

class UpdateAddressEvent extends AddressEvent {
  final int addressId;
  final CustomerAddressModelForSend addressModel;

  UpdateAddressEvent({
    required this.addressId,
    required this.addressModel,
  });
}


// ============================================================
// Delete
// ============================================================

class DeleteAddressEvent extends AddressEvent {
  final int addressId;

  DeleteAddressEvent({
    required this.addressId,
  });

}