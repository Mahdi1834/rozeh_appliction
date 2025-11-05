part of 'reservation_bloc.dart';

@immutable
abstract class RozehTypeStatus {}

class RozehTypeStatusInit extends RozehTypeStatus {}

class RozehTypeStatusLoading extends RozehTypeStatus {}

class RozehTypeStatusCompleted extends RozehTypeStatus {
  final RozehTypeModel rozehTypeModel;

  RozehTypeStatusCompleted(this.rozehTypeModel);
}

class RozehTypeStatusError extends RozehTypeStatus {
  final String? message;

  RozehTypeStatusError(this.message);
}
