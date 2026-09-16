part of 'home_bloc.dart';

@immutable
class HomeState {
  final CurrentHadithStatus currentHadithStatus;

  final BannersStatus bannersStatus;

  const HomeState({
    required this.currentHadithStatus,

    required this.bannersStatus,
  });

  HomeState copyWith({
    CurrentHadithStatus? newCurrentHadithStatus,

    BannersStatus? newBannersStatus,
  }) {
    return HomeState(

      currentHadithStatus: newCurrentHadithStatus ?? currentHadithStatus,
      bannersStatus:  newBannersStatus ?? bannersStatus,
    );
  }
}
