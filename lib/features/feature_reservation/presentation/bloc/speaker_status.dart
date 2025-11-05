part of 'reservation_bloc.dart';


@immutable
abstract class SpeakerStatus{}

class SpeakerStatusInit extends SpeakerStatus{}
class SpeakerStatusLoading extends SpeakerStatus{}
class SpeakerStatusCompleted extends SpeakerStatus{
  final SpeakerModel speakerModel;

  SpeakerStatusCompleted(this.speakerModel);

}
class SpeakerStatusError extends SpeakerStatus{
  final String? message;

  SpeakerStatusError(this.message);

}