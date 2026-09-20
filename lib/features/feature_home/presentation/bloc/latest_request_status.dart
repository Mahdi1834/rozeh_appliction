part of 'home_bloc.dart';

@immutable
abstract class LatestRequestCustomerStatus {}

class LatestRequestCustomerStatusInit extends LatestRequestCustomerStatus {}

class LatestRequestCustomerStatusLoading extends LatestRequestCustomerStatus {}

class LatestRequestCustomerStatusCompleted extends LatestRequestCustomerStatus {
  final LatestRequestsCustomerModel latestRequestsCustomerModel;

  LatestRequestCustomerStatusCompleted(this.latestRequestsCustomerModel);
}

class LatestRequestCustomerStatusError extends LatestRequestCustomerStatus {
  final String? message;

  LatestRequestCustomerStatusError(this.message);
}
