part of 'niyabat_bloc.dart';

@immutable
sealed class NiyabatEvent {}

// ============================================================
// List
// ============================================================

class ListNiyabatEvent extends NiyabatEvent {
  final int page;

  ListNiyabatEvent({this.page = 1});
}

// ============================================================
// Get Intentions
// ============================================================

class GetIntentionEvent extends NiyabatEvent {}

// ============================================================
// Get Tavaslats
// ============================================================

class GetTavaslatEvent extends NiyabatEvent {}

// ============================================================
// Store
// ============================================================

class StoreNiyabatEvent extends NiyabatEvent {
  final NiyabatModelForSend niyabatModelForSend;

  StoreNiyabatEvent({required this.niyabatModelForSend});
}

// ============================================================
// Update
// ============================================================

class UpdateNiyabatEvent extends NiyabatEvent {
  final int niyabatId;
  final NiyabatModelForSend niyabatModelForSend;

  UpdateNiyabatEvent({
    required this.niyabatId,
    required this.niyabatModelForSend,
  });
}

// ============================================================
// Delete
// ============================================================

class DeleteNiyabatEvent extends NiyabatEvent {
  final int niyabatId;

  DeleteNiyabatEvent({required this.niyabatId});
}
