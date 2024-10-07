import '../models/auth_response_model.dart';
import '../models/profile_response_model.dart';
import '../remote/api_service.dart';
import '../remote/auth_api_service.dart';

abstract class AuthRepository {
  Future<AuthResponseModel> login(String email, String password);
  Future<AuthResponseModel> register(String username, String password);
  Future<ProfileResponseModel> getProfile();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService apiService;
  final ApiService api;


  AuthRepositoryImpl(this.apiService, this.api);

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    print('AuthRepositoryImpl: $email -- $password', );
    return await apiService.login({"email": email, "password": password});
  }

  @override
  Future<AuthResponseModel> register(String username, String password) async {
    return await apiService.register({"username": username, "password": password});
  }

  @override
  Future<ProfileResponseModel> getProfile() async {
    print("AuthRepositoryImpl");
    return await api.getProfile();
  }
}
