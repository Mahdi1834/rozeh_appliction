import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

Future<void> initLocator() async{
  locator.registerSingleton<Dio>(Dio());

  //
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // locator.registerSingleton<SharedPreferences>(sharedPreferences);










}