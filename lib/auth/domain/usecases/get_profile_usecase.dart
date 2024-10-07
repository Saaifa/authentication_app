import 'package:authentication/auth/data/repositories/auth_repository.dart';
import '../../data/models/profile_response_model.dart';

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileResponseModel> call() async {
    print("GetProfileUseCase getProfile");
    return await repository.getProfile();
  }
}
