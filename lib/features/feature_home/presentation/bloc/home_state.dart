part of 'home_bloc.dart';

@immutable
class HomeState {
  final CurrentHadithStatus currentHadithStatus;

  const HomeState({required this.currentHadithStatus});

  HomeState copyWith({CurrentHadithStatus? newCurrentHadithStatus}) {
    return HomeState(
      currentHadithStatus: newCurrentHadithStatus ?? currentHadithStatus,
    );
  }
}
