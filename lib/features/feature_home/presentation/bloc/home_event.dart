part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


class GetCurrentHadithEvent extends HomeEvent{}

class GetRozehRequestEvent extends HomeEvent{
  final String page ;
  final String? query;

  GetRozehRequestEvent({required this.page, this.query});
}