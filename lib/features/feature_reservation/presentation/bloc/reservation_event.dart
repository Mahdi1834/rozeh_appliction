part of 'reservation_bloc.dart';

@immutable
sealed class ReservationEvent {}

class GetMaddahEvent extends ReservationEvent {}

class GetSpeakerEvent extends ReservationEvent {}

class GetRozehTypeEvent extends ReservationEvent {}

class GetAgeGroupEvent extends ReservationEvent {}

class StoreRozehRequestEvent extends ReservationEvent {

  final RozehRequestSendModel rozehRequestSendModel;

  StoreRozehRequestEvent({required this.rozehRequestSendModel});
}

class GetRozehRequestEvent extends ReservationEvent {
  final String page;

  final String? query;

  GetRozehRequestEvent({required this.page, this.query});
}
