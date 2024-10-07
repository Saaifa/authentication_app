import 'dart:math';

import 'package:authentication/auth/data/models/auth_response_model.dart';
import 'package:authentication/auth/data/repositories/auth_repository.dart';


class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResponseModel> call(String email, String password) async {
    print('loginUseCase: $email -- $password', );
    return await repository.login(email, password);
  }
}
