import 'package:authentication/auth/data/models/auth_response_model.dart';
import 'package:authentication/auth/data/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthResponseModel> call(String username, String password) async {
    return await repository.register(username, password);
  }
}
