import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/age_group_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/maddah_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_send_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_request_store_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/rozeh_type_model.dart';
import 'package:rozeh_project/features/feature_reservation/data/model/speaker_model.dart';
import 'package:rozeh_project/features/feature_reservation/repositories/reservation_repository.dart';

part 'reservation_event.dart';

part 'reservation_state.dart';

part 'maddah_status.dart';

part 'speaker_status.dart';

part 'type_rozeh_status.dart';

part 'rozeh_request_store_status.dart';

part 'age_group_status.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationRepository reservationRepository;

  ReservationBloc(this.reservationRepository)
    : super(
        ReservationState(
          maddahStatus: MaddahStatusInit(),
          speakerStatus: SpeakerStatusInit(),
          rozehTypeStatus: RozehTypeStatusInit(),
          ageGroupStatus: AgeGroupStatusInit(),
          rozehRequestStoreStatus: RozehRequestStoreStatusInit(),
        ),
      ) {
    ////////////////////////////
    on<GetMaddahEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newMaddahStatus: MaddahStatusLoading()));
      DataState dataState = await reservationRepository.fetchMaddah();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newMaddahStatus: MaddahStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(newMaddahStatus: MaddahStatusError(dataState.error!)),
        );
      }
    });

    ////////////////////////////
    on<GetSpeakerEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newSpeakerStatus: SpeakerStatusLoading()));
      DataState dataState = await reservationRepository.fetchSpeaker();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newSpeakerStatus: SpeakerStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newSpeakerStatus: SpeakerStatusError(dataState.error!),
          ),
        );
      }
    });

    ////////////////////////////
    on<GetRozehTypeEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newRozehTypeStatus: RozehTypeStatusLoading()));
      DataState dataState = await reservationRepository.fetchRozehType();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newRozehTypeStatus: RozehTypeStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newRozehTypeStatus: RozehTypeStatusError(dataState.error!),
          ),
        );
      }
    });

    ////////////////////////////
    on<GetAgeGroupEvent>((event, emit) async {
      // TODO: implement event handler
      emit(state.copyWith(newAgeGroupStatus: AgeGroupStatusLoading()));
      DataState dataState = await reservationRepository.fetchAgeGroup();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newAgeGroupStatus: AgeGroupStatusCompleted(dataState.data),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newAgeGroupStatus: AgeGroupStatusError(dataState.error!),
          ),
        );
      }
    });

    ////////////////////////////
    on<StoreRozehRequestEvent>((event, emit) async {
      // TODO: implement event handler
      emit(
        state.copyWith(newRozehRequestStoreStatus: RozehRequestStoreStatusLoading()),
      );
      DataState dataState = await reservationRepository.fetchRozehRequestStore(
        rozehRequestSendModel: event.rozehRequestSendModel,
      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newRozehRequestStoreStatus: RozehRequestStoreStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newRozehRequestStoreStatus: RozehRequestStoreStatusError(dataState.error!),
          ),
        );
      }
    });
  }
}
