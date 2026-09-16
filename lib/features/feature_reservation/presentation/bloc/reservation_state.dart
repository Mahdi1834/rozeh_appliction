part of 'reservation_bloc.dart';

@immutable
class ReservationState {
  final MaddahStatus maddahStatus;
  final SpeakerStatus speakerStatus;
  final RozehTypeStatus rozehTypeStatus;
  final AgeGroupStatus ageGroupStatus;
  final RozehRequestStoreStatus rozehRequestStoreStatus;
  final RozehRequestStatus rozehRequestStatus;

  const ReservationState({
    required this.maddahStatus,
    required this.speakerStatus,
    required this.rozehTypeStatus,
    required this.ageGroupStatus,
    required this.rozehRequestStoreStatus,
    required this.rozehRequestStatus,
  });

  ReservationState copyWith({
    MaddahStatus? newMaddahStatus,
    SpeakerStatus? newSpeakerStatus,
    RozehTypeStatus? newRozehTypeStatus,
    AgeGroupStatus? newAgeGroupStatus,
    RozehRequestStoreStatus? newRozehRequestStoreStatus,
    RozehRequestStatus? newRozehRequestStatus,
  }) {
    return ReservationState(
      maddahStatus: newMaddahStatus ?? maddahStatus,
      speakerStatus: newSpeakerStatus ?? speakerStatus,
      rozehTypeStatus: newRozehTypeStatus ?? rozehTypeStatus,
      ageGroupStatus: newAgeGroupStatus ?? ageGroupStatus,
      rozehRequestStoreStatus:
          newRozehRequestStoreStatus ?? rozehRequestStoreStatus,
      rozehRequestStatus: newRozehRequestStatus ?? rozehRequestStatus,
    );
  }
}
