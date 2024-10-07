import 'package:authentication/auth/domain/usecases/get_profile_usecase.dart';
import 'package:authentication/auth/domain/usecases/login_usecase.dart';
import 'package:authentication/auth/domain/usecases/register_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/auth_response_model.dart';
import '';
import '../../data/models/profile_response_model.dart';
import 'package:bloc/bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetProfileUseCase getProfileUseCase;

  String? accessToken;
  String? refreshToken;

  AuthCubit(
    this.loginUseCase,
    this.registerUseCase,
    this.getProfileUseCase,
  ) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      print('AuthCubit: $email -- $password');
      final authResponse = await loginUseCase(email, password);
      if (authResponse.status?.code == 200) {
        accessToken = authResponse.token?.access;
        refreshToken = authResponse.token?.refresh;

        // Make sure tokens are not null before saving
        if (accessToken != null && refreshToken != null) {

          await setValue("accessToken",accessToken!);
          await setValue("refresh_token",refreshToken!);
          emit(AuthSuccess(accessToken!, refreshToken!));
        } else {
          emit(AuthFailure("Tokens are null"));
        }
      } else {
        emit(AuthFailure("Please enter correct credentials"));
      }
    } catch (e) {
      print('AuthFailure: ${e.toString()}');
      emit(AuthFailure(e.toString()));  // Removed `throw` to prevent crashing
    }
  }

  Future<void> register(String username, String password) async {
    emit(AuthLoading());
    try {
      final authResponse = await registerUseCase(username, password);
      // accessToken = authResponse.accessToken;
      // refreshToken = authResponse.refreshToken;
      // emit(AuthSuccess(authResponse.accessToken, authResponse.refreshToken));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> getProfile() async {
    print("AuthCubit getProfile");
    emit(AuthLoading());
    try {
      print("AuthCubit getProfile");
      final profile = await getProfileUseCase();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> setValue(String key, dynamic value) async{
    final prefs = await SharedPreferences.getInstance();
    print("setvalue: $key === $value");
    await prefs.setString(key, value);
  }

  Future<Map<String, String?>> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    return {
      'email': email,
      'password': password,
    };
  }

}
