part of 'home_bloc.dart';

@immutable
class HomeState {
  final CurrentHadithStatus currentHadithStatus;
  final RozehRequestStatus rozehRequestStatus;

  const HomeState({
    required this.currentHadithStatus,
    required this.rozehRequestStatus,
  });

  HomeState copyWith({
    CurrentHadithStatus? newCurrentHadithStatus,
    RozehRequestStatus? newRozehRequestStatus,
  }) {
    return HomeState(
      rozehRequestStatus: newRozehRequestStatus ?? rozehRequestStatus,
      currentHadithStatus: newCurrentHadithStatus ?? currentHadithStatus,
    );
  }
}
