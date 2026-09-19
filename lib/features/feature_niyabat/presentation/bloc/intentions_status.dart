part of "niyabat_bloc.dart";


@immutable
abstract class IntentionsStatus{}

class IntentionsStatusInit extends IntentionsStatus{}
class IntentionsStatusLoading extends IntentionsStatus{}
class IntentionsStatusCompleted extends IntentionsStatus{
  final IntentionsModel intentionsModel;

  IntentionsStatusCompleted(this.intentionsModel);

}
class IntentionsStatusError extends IntentionsStatus{
  final String? message;

  IntentionsStatusError(this.message);

}