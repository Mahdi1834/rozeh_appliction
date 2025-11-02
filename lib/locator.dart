import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rozeh_project/core/storage/user_session.dart';
import 'package:rozeh_project/features/feature_login/data/api/login_api_provider.dart';
import 'package:rozeh_project/features/feature_login/presentation/bloc/login_bloc.dart';
import 'package:rozeh_project/features/feature_login/repositories/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt locator = GetIt.instance;

Future<void> initLocator() async{
  locator.registerSingleton<Dio>(Dio());

  ///  SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  ///api provider
  locator.registerSingleton<LoginApiProvider>(LoginApiProvider(locator()));

  ///repository
  locator.registerSingleton<LoginRepository>(LoginRepository(locator()));

  ///bloc
  locator.registerSingleton<LoginBloc>(LoginBloc(locator()));

  //
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);




  // User Session
  locator.registerSingleton<UserSession>(UserSession(locator()));






}