part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
final class AuthLogin extends AuthEvent {
  final String contact;
  // final String password;

  AuthLogin({
    required this.contact,
    // required this.password,
  });
}

final class AuthIsUserLoggedIn extends AuthEvent {}
final class AuthLogoutRequested extends AuthEvent {}
