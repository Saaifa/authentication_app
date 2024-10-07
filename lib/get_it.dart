import 'package:authentication/auth/data/remote/api_service.dart';
import 'package:authentication/auth/data/remote/auth_api_service.dart';
import 'package:authentication/auth/data/repositories/auth_repository.dart';
import 'package:authentication/auth/domain/usecases/get_profile_usecase.dart';
import 'package:authentication/auth/domain/usecases/login_usecase.dart';
import 'package:authentication/auth/domain/usecases/register_usecase.dart';
import 'package:authentication/auth/presenation/cubit/auth_cubit.dart';
import 'package:authentication/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setup() {
  final dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestBody: true,
    requestHeader: true
  ));

  final _authDio = Dio();
  _authDio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true
  ));
  _authDio.interceptors.add(AuthInterceptor(_authDio));


  sl.registerFactory(() => AuthApiService(dio));
  sl.registerFactory(() => ApiService(_authDio));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerFactory(() => LoginUseCase(sl()));
  sl.registerFactory(() => RegisterUseCase(sl()));
  sl.registerFactory(() => GetProfileUseCase(sl()));
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => AuthInterceptor(_authDio));



}
