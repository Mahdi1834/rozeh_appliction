import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/customer_address_model_for_send.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/delete_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/list_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/data/model/store_address_model.dart';
import 'package:rozeh_project/features/feature_list_address/repositories/address_repository.dart';

part 'address_event.dart';
part 'address_state.dart';
part 'list_address_status.dart';
part 'delete_address_status.dart';
part 'store_address_status.dart';
part 'update_address_status.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;

  AddressBloc(this.addressRepository)
      : super(
    AddressState(
      listAddressStatus: ListAddressStatusInit(),
      storeAddressStatus: StoreAddressStatusInit(),
      updateAddressStatus: UpdateAddressStatusInit(),
      deleteAddressStatus: DeleteAddressStatusInit(),
    ),
  ) {

    // ============================================================
    // Get Addresses
    // ============================================================

    on<ListAddressEvent>((event, emit) async {
      emit(
        state.copyWith(
          newListAddressStatus: ListAddressStatusLoading(),
        ),
      );

      DataState dataState =
      await addressRepository.fetchAddresses();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newListAddressStatus: ListAddressStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newListAddressStatus: ListAddressStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });

    // ============================================================
    // Store Address
    // ============================================================

    on<StoreAddressEvent>((event, emit) async {
      emit(
        state.copyWith(
          newStoreAddressStatus: StoreAddressStatusLoading(),
        ),
      );

      DataState dataState =
      await addressRepository.createAddress(
        addressModel: event.addressModel,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newStoreAddressStatus: StoreAddressStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newStoreAddressStatus: StoreAddressStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });

    // ============================================================
    // Update Address
    // ============================================================

    on<UpdateAddressEvent>((event, emit) async {
      emit(
        state.copyWith(
          newUpdateAddressStatus: UpdateAddressStatusLoading(),
        ),
      );

      DataState dataState =
      await addressRepository.updateAddress(
        addressId: event.addressId,
        addressModel: event.addressModel,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newUpdateAddressStatus: UpdateAddressStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newUpdateAddressStatus: UpdateAddressStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });

    // ============================================================
    // Delete Address
    // ============================================================

    on<DeleteAddressEvent>((event, emit) async {
      emit(
        state.copyWith(
          newDeleteAddressStatus: DeleteAddressStatusLoading(),
        ),
      );

      DataState dataState =
      await addressRepository.deleteAddress(
        addressId: event.addressId,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newDeleteAddressStatus: DeleteAddressStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newDeleteAddressStatus: DeleteAddressStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });
  }
}