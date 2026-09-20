part of 'home_bloc.dart';

@immutable
class HomeState {
  final CurrentHadithStatus currentHadithStatus;
  final LatestRequestCustomerStatus latestRequestCustomerStatus;
  final BannersStatus bannersStatus;

  const HomeState({
    required this.currentHadithStatus,
    required this.latestRequestCustomerStatus,
    required this.bannersStatus,
  });

  HomeState copyWith({
    CurrentHadithStatus? newCurrentHadithStatus,
    LatestRequestCustomerStatus? newLatestRequestCustomerStatus,
    BannersStatus? newBannersStatus,
  }) {
    return HomeState(
      currentHadithStatus: newCurrentHadithStatus ?? currentHadithStatus,
      bannersStatus: newBannersStatus ?? bannersStatus,
      latestRequestCustomerStatus:
          newLatestRequestCustomerStatus ?? latestRequestCustomerStatus,
    );
  }
}
