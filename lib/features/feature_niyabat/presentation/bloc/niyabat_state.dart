part of 'niyabat_bloc.dart';

@immutable
class NiyabatState {
  final ListNiyabatStatus listNiyabatStatus;
  final StoreNiyabatStatus storeNiyabatStatus;
  final UpdateNiyabatStatus updateNiyabatStatus;
  final DeleteNiyabatStatus deleteNiyabatStatus;
  final TavaslatsStatus tavaslatsStatus;
  final IntentionsStatus intentionsStatus;

  const NiyabatState({
    required this.listNiyabatStatus,
    required this.storeNiyabatStatus,
    required this.updateNiyabatStatus,
    required this.deleteNiyabatStatus,
    required this.tavaslatsStatus,
    required this.intentionsStatus,
  });

  NiyabatState copyWith({
    ListNiyabatStatus? newListNiyabatStatus,

    StoreNiyabatStatus? newStoreNiyabatStatus,
    UpdateNiyabatStatus? newUpdateNiyabatStatus,
    DeleteNiyabatStatus? newDeleteNiyabatStatus,
    TavaslatsStatus? newTavaslatsStatus,
    IntentionsStatus? newIntentionsStatus,
  }) {
    return NiyabatState(
      listNiyabatStatus: newListNiyabatStatus ?? listNiyabatStatus,
      storeNiyabatStatus: newStoreNiyabatStatus ?? storeNiyabatStatus,
      updateNiyabatStatus: newUpdateNiyabatStatus ?? updateNiyabatStatus,
      deleteNiyabatStatus: newDeleteNiyabatStatus ?? deleteNiyabatStatus,
      tavaslatsStatus: newTavaslatsStatus ?? tavaslatsStatus,
      intentionsStatus: newIntentionsStatus ?? intentionsStatus,
    );
  }
}
