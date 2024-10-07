part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String accessToken;
  final String refreshToken;

  AuthSuccess(this.accessToken, this.refreshToken);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class ProfileLoaded extends AuthState {
  final ProfileResponseModel profile;
  ProfileLoaded(this.profile);
}
