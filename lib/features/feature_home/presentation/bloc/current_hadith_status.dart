part of 'home_bloc.dart';


@immutable
abstract class CurrentHadithStatus{}

class CurrentHadithStatusInit extends CurrentHadithStatus{}
class CurrentHadithStatusLoading extends CurrentHadithStatus{}
class CurrentHadithStatusCompleted extends CurrentHadithStatus{
  final CurrentHadithModel currentHadithModel;

  CurrentHadithStatusCompleted(this.currentHadithModel);

}
class CurrentHadithStatusError extends CurrentHadithStatus{
  final String? message;

  CurrentHadithStatusError(this.message);

}