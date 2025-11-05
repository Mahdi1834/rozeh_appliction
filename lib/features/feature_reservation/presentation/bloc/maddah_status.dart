part of 'reservation_bloc.dart';



@immutable
abstract class MaddahStatus{}

class MaddahStatusInit extends MaddahStatus{}
class MaddahStatusLoading extends MaddahStatus{}
class MaddahStatusCompleted extends MaddahStatus{
  final MaddahModel maddahModel;

  MaddahStatusCompleted(this.maddahModel);

}
class MaddahStatusError extends MaddahStatus{
  final String? message;

  MaddahStatusError(this.message);

}