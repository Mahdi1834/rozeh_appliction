part of "niyabat_bloc.dart";

@immutable
abstract class TavaslatsStatus {}

class TavaslatsStatusInit extends TavaslatsStatus {}

class TavaslatsStatusLoading extends TavaslatsStatus {}

class TavaslatsStatusCompleted extends TavaslatsStatus {
  final TavaslatsModel tavaslatsModel;

  TavaslatsStatusCompleted(this.tavaslatsModel);
}

class TavaslatsStatusError extends TavaslatsStatus {
  final String? message;

  TavaslatsStatusError(this.message);
}
