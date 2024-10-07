import 'package:authentication/auth/data/models/profile_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/auth_response_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.25:8000/api/v1/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/profile")
  Future<ProfileResponseModel> getProfile();


}
