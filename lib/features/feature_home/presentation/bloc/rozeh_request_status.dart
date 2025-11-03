part of 'home_bloc.dart';


@immutable
abstract class RozehRequestStatus{}

class RozehRequestStatusInit extends RozehRequestStatus{}
class RozehRequestStatusLoading extends RozehRequestStatus{}
class RozehRequestStatusCompleted extends RozehRequestStatus{
  final RozehRequestModel rozehRequestModel;

  RozehRequestStatusCompleted(this.rozehRequestModel);

}
class RozehRequestStatusError extends RozehRequestStatus{
  final String? message;

  RozehRequestStatusError(this.message);

}