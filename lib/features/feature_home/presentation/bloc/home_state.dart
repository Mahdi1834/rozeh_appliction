part of 'home_bloc.dart';

@immutable
class HomeState {
  final CurrentHadithStatus currentHadithStatus;
  final RozehRequestStatus rozehRequestStatus;
  final BannersStatus bannersStatus;

  const HomeState({
    required this.currentHadithStatus,
    required this.rozehRequestStatus,
    required this.bannersStatus,
  });

  HomeState copyWith({
    CurrentHadithStatus? newCurrentHadithStatus,
    RozehRequestStatus? newRozehRequestStatus,
    BannersStatus? newBannersStatus,
  }) {
    return HomeState(
      rozehRequestStatus: newRozehRequestStatus ?? rozehRequestStatus,
      currentHadithStatus: newCurrentHadithStatus ?? currentHadithStatus,
      bannersStatus:  newBannersStatus ?? bannersStatus,
    );
  }
}
