part of 'address_bloc.dart';

@immutable
class AddressState {
  final ListAddressStatus listAddressStatus;
  final UpdateAddressStatus updateAddressStatus;
  final DeleteAddressStatus deleteAddressStatus;
  final StoreAddressStatus storeAddressStatus;

  const AddressState({
    required this.listAddressStatus,
    required this.updateAddressStatus,
    required this.deleteAddressStatus,
    required this.storeAddressStatus,
  });


  AddressState copyWith({
    ListAddressStatus? newListAddressStatus,
    UpdateAddressStatus? newUpdateAddressStatus,
    DeleteAddressStatus? newDeleteAddressStatus,
    StoreAddressStatus? newStoreAddressStatus,

  }) {
    return AddressState(
        listAddressStatus: newListAddressStatus ?? listAddressStatus,
        updateAddressStatus: newUpdateAddressStatus ?? updateAddressStatus,
        deleteAddressStatus: newDeleteAddressStatus ?? deleteAddressStatus,
        storeAddressStatus: newStoreAddressStatus ?? storeAddressStatus);
  }
}
