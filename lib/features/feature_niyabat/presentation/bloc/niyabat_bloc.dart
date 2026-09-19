import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/delete_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/intentions_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/list_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/niyabat_model_for_send.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/store_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/tavaslats_model.dart';
import 'package:rozeh_project/features/feature_niyabat/data/model/update_niyabat_model.dart';
import 'package:rozeh_project/features/feature_niyabat/repositories/niyabat_repository.dart';

part 'niyabat_event.dart';

part 'niyabat_state.dart';

part 'list_niyabat_status.dart';

part 'update_niyabat_status.dart';

part 'delete_niyabat_status.dart';

part 'store_niyabat_status.dart';

part 'intentions_status.dart';

part 'tavaslats_status.dart';

class NiyabatBloc extends Bloc<NiyabatEvent, NiyabatState> {
  final NiyabatRepository niyabatRepository;

  NiyabatBloc(this.niyabatRepository)
    : super(
        NiyabatState(
          listNiyabatStatus: ListNiyabatStatusInit(),
          storeNiyabatStatus: StoreNiyabatStatusInit(),
          updateNiyabatStatus: UpdateNiyabatStatusInit(),
          deleteNiyabatStatus: DeleteNiyabatStatusInit(),
          intentionsStatus: IntentionsStatusInit(),
          tavaslatsStatus: TavaslatsStatusInit(),
        ),
      ) {
    // ============================================================
    // Get Niyabats
    // ============================================================

    on<ListNiyabatEvent>((event, emit) async {
      emit(state.copyWith(newListNiyabatStatus: ListNiyabatStatusLoading()));

      DataState dataState = await niyabatRepository.fetchNiyabats(
        page: event.page,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newListNiyabatStatus: ListNiyabatStatusCompleted(dataState.data),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newListNiyabatStatus: ListNiyabatStatusError(dataState.error!),
          ),
        );
      }
    });

    // ============================================================
    // Get Intentions
    // ============================================================

    on<GetIntentionEvent>((event, emit) async {
      emit(state.copyWith(newIntentionsStatus: IntentionsStatusLoading()));

      DataState dataState = await niyabatRepository.fetchIntentions();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newIntentionsStatus: IntentionsStatusCompleted(dataState.data),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newIntentionsStatus: IntentionsStatusError(dataState.error!),
          ),
        );
      }
    });

    // ============================================================
    // Get Tavaslats
    // ============================================================

    on<GetTavaslatEvent>((event, emit) async {
      emit(state.copyWith(newTavaslatsStatus: TavaslatsStatusLoading()));

      DataState dataState = await niyabatRepository.fetchTavaslats();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newTavaslatsStatus: TavaslatsStatusCompleted(dataState.data),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newTavaslatsStatus: TavaslatsStatusError(dataState.error!),
          ),
        );
      }
    });

    // ============================================================
    // Store Niyabat
    // ============================================================

    on<StoreNiyabatEvent>((event, emit) async {
      emit(state.copyWith(newStoreNiyabatStatus: StoreNiyabatStatusLoading()));

      DataState dataState = await niyabatRepository.createNiyabat(
        niyabatModelForSend: event.niyabatModelForSend,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newStoreNiyabatStatus: StoreNiyabatStatusCompleted(dataState.data),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newStoreNiyabatStatus: StoreNiyabatStatusError(dataState.error!),
          ),
        );
      }
    });

    // ============================================================
    // Update Niyabat
    // ============================================================

    on<UpdateNiyabatEvent>((event, emit) async {
      emit(
        state.copyWith(newUpdateNiyabatStatus: UpdateNiyabatStatusLoading()),
      );

      DataState dataState = await niyabatRepository.updateNiyabat(
        niyabatId: event.niyabatId,
        niyabatModelForSend: event.niyabatModelForSend,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newUpdateNiyabatStatus: UpdateNiyabatStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newUpdateNiyabatStatus: UpdateNiyabatStatusError(dataState.error!),
          ),
        );
      }
    });

    // ============================================================
    // Delete Niyabat
    // ============================================================

    on<DeleteNiyabatEvent>((event, emit) async {
      emit(
        state.copyWith(newDeleteNiyabatStatus: DeleteNiyabatStatusLoading()),
      );

      DataState dataState = await niyabatRepository.deleteNiyabat(
        niyabatId: event.niyabatId,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newDeleteNiyabatStatus: DeleteNiyabatStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }

      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newDeleteNiyabatStatus: DeleteNiyabatStatusError(dataState.error!),
          ),
        );
      }
    });
  }
}
