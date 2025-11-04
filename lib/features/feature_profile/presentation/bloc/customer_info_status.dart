part of 'profile_bloc.dart';


@immutable
abstract class CustomerInfoStatus{}

class CustomerInfoStatusInit extends CustomerInfoStatus{}
class CustomerInfoStatusLoading extends CustomerInfoStatus{}
class CustomerInfoStatusCompleted extends CustomerInfoStatus{
  final CustomerInfoModel customerInfoModel;

  CustomerInfoStatusCompleted(this.customerInfoModel);

}
class CustomerInfoStatusError extends CustomerInfoStatus{
  final String? message;

  CustomerInfoStatusError(this.message);

}