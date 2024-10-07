import 'package:authentication/auth/data/models/auth_response_model.dart';
import 'package:authentication/auth/data/remote/auth_api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/presenation/cubit/auth_cubit.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Add access token to the headers
      final prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString("accessToken");
      print("access_token: $accessToken");
      options.headers['Authorization'] = 'Bearer $accessToken';

    return handler.next(options); // Continue with the request
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error is due to an expired access token
    // if (err.response?.statusCode == 401) {
    //   try {
    //     // final refreshToken = authCubit.refreshToken;
    //     // if (refreshToken != null) {
    //     //   // Attempt to refresh the token
    //     //   final newTokens = await _refreshToken(refreshToken);
    //     //   authCubit.accessToken = newTokens.token?.access;
    //     //   authCubit.refreshToken = newTokens.token?.refresh;
    //
    //       // Retry the original request with the new token
    //       final requestOptions = err.requestOptions;
    //       requestOptions.headers['Authorization'] =
    //           'Bearer ${newTokens.token?.access}';
    //       final response = await dio.request(
    //         requestOptions.path,
    //         options: Options(
    //           method: requestOptions.method,
    //           headers: requestOptions.headers,
    //         ),
    //         data: requestOptions.data,
    //         queryParameters: requestOptions.queryParameters,
    //       );
    //       return handler.resolve(response); // Continue with the new response
    //     }
    //   } catch (e) {
    //     return handler
    //         .next(err); // If refreshing the token fails, pass the error
    //   }
    }

    // return handler.next(err); // Pass any other errors
  }

  Future<AuthResponseModel> _refreshToken(String refreshToken) async {
    final authApiService = GetIt.I<AuthApiService>();
    final response =
        await authApiService.refreshToken({"refreshToken": refreshToken});
    return response;

}
