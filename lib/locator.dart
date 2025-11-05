import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_home/data/api/home_api_provider.dart';
import 'package:rozeh_project/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:rozeh_project/features/feature_home/repositories/home_repository.dart';
import 'package:rozeh_project/features/feature_login/data/api/login_api_provider.dart';
import 'package:rozeh_project/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:rozeh_project/features/feature_login/repositories/login_repository.dart';
import 'package:rozeh_project/features/feature_profile/data/api/profile_api_provider.dart';
import 'package:rozeh_project/features/feature_profile/presentation/bloc/profile_bloc.dart';
import 'package:rozeh_project/features/feature_profile/repositories/profile_repository.dart';
import 'package:rozeh_project/features/feature_reservation/data/api/reservation_api_provider.dart';
import 'package:rozeh_project/features/feature_reservation/presentation/bloc/reservation_bloc.dart';
import 'package:rozeh_project/features/feature_reservation/repositories/reservation_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt locator = GetIt.instance;

Future<void> initLocator() async{
  locator.registerSingleton<Dio>(Dio());

  ///  SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  ///api provider
  locator.registerSingleton<LoginApiProvider>(LoginApiProvider(locator()));
  locator.registerSingleton<HomeApiProvider>(HomeApiProvider(locator()));
  locator.registerSingleton<ProfileApiProvider>(ProfileApiProvider(locator()));
  locator.registerSingleton<ReservationApiProvider>(ReservationApiProvider(locator()));

  ///repository
  locator.registerSingleton<LoginRepository>(LoginRepository(locator()));
  locator.registerSingleton<HomeRepository>(HomeRepository(locator()));
  locator.registerSingleton<ProfileRepository>(ProfileRepository(locator()));
  locator.registerSingleton<ReservationRepository>(ReservationRepository(locator()));

  ///bloc
  locator.registerSingleton<LoginBloc>(LoginBloc(locator()));
  locator.registerSingleton<HomeBloc>(HomeBloc(locator()));
  locator.registerSingleton<ProfileBloc>(ProfileBloc(locator()));
  locator.registerSingleton<ReservationBloc>(ReservationBloc(locator()));

  //
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);




  // User Session
  locator.registerSingleton<UserSession>(UserSession(locator()));






}