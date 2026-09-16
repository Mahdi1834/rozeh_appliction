import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rozeh_project/core/resources/data_state.dart';
import 'package:rozeh_project/features/feature_home/data/model/banners_model.dart';
import 'package:rozeh_project/features/feature_home/data/model/current_hadith_model.dart';

import 'package:rozeh_project/features/feature_home/repositories/home_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'current_hadith_status.dart';



part 'banners_status.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository;

  HomeBloc(this.homeRepository)
      : super(HomeState(

      currentHadithStatus: CurrentHadithStatusInit(),
      bannersStatus: BannersStatusInit(),
  )) {
    on<GetCurrentHadithEvent>((event, emit) async {
      // TODO: implement event handler
      emit(
        state.copyWith(
          newCurrentHadithStatus: CurrentHadithStatusLoading(),
        ),
      );
      DataState dataState = await homeRepository.fetchCurrentHadith(

      );

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newCurrentHadithStatus: CurrentHadithStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newCurrentHadithStatus: CurrentHadithStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });

    ///////////// banners /////////////

    on<GetBannersEvent>((event, emit) async {
      emit(
        state.copyWith(
          newBannersStatus: BannersStatusLoading(),
        ),
      );
      DataState dataState = await homeRepository.fetchBanners();

      if (dataState is DataSuccess) {
        emit(
          state.copyWith(
            newBannersStatus: BannersStatusCompleted(
              dataState.data,
            ),
          ),
        );
      }
      if (dataState is DataFailed) {
        emit(
          state.copyWith(
            newBannersStatus: BannersStatusError(
              dataState.error!,
            ),
          ),
        );
      }
    });
  }


}
