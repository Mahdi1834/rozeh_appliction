part of 'reservation_bloc.dart';

@immutable
class ReservationState {
  final MaddahStatus maddahStatus;
  final SpeakerStatus speakerStatus;
  final RozehTypeStatus rozehTypeStatus;
  final AgeGroupStatus ageGroupStatus;
  final RozehRequestStoreStatus rozehRequestStoreStatus;

  const ReservationState({
    required this.maddahStatus,
    required this.speakerStatus,
    required this.rozehTypeStatus,
    required this.ageGroupStatus,
    required this.rozehRequestStoreStatus,
  });

  ReservationState copyWith({
    MaddahStatus? newMaddahStatus,
    SpeakerStatus? newSpeakerStatus,
    RozehTypeStatus? newRozehTypeStatus,
    AgeGroupStatus? newAgeGroupStatus,
    RozehRequestStoreStatus? newRozehRequestStoreStatus,
  }) {
    return ReservationState(
      maddahStatus: newMaddahStatus ?? maddahStatus,
      speakerStatus: newSpeakerStatus ?? speakerStatus,
      rozehTypeStatus: newRozehTypeStatus ?? rozehTypeStatus,
      ageGroupStatus: newAgeGroupStatus ?? ageGroupStatus,
      rozehRequestStoreStatus:
          newRozehRequestStoreStatus ?? rozehRequestStoreStatus,
    );
  }
}
