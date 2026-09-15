part of 'home_bloc.dart';


@immutable
abstract class BannersStatus{}

class BannersStatusInit extends BannersStatus{}
class BannersStatusLoading extends BannersStatus{}
class BannersStatusCompleted extends BannersStatus{
  final BannersModel bannersModel;

  BannersStatusCompleted(this.bannersModel);

}
class BannersStatusError extends BannersStatus{
  final String? message;

  BannersStatusError(this.message);

}