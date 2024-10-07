import 'package:authentication/auth/data/models/profile_response_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/auth_response_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: "http://192.168.1.25:8000/api/v1/")
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST("/login")
  Future<AuthResponseModel> login(@Body() Map<String, dynamic> body);

  @POST("/register")
  Future<AuthResponseModel> register(@Body() Map<String, dynamic> body);

  @GET("/profile")
  Future<ProfileResponseModel> getProfile();

  @POST("/refresh-token")
  Future<AuthResponseModel> refreshToken(@Body() Map<String, dynamic> body);

}
