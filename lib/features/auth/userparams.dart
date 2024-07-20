import 'dart:developer';
import 'package:fpdart/fpdart.dart';
import 'package:vFASHU/features/auth/domain/model.dart';
import 'package:vFASHU/features/auth/domain/repository/auth_repository.dart';
import '../../error/failures.dart';

class UserLogin {
  final AuthRepository? authRepository;

  const UserLogin({this.authRepository});

  Future<Either<Failure, UserSendOTP>?> call(UserLoginParams params) async {
    log("params");
    return await authRepository?.loginWithEmailPassword(
      number: params.number,
    );
  }
}

class UserLoginParams {
  final String number;

  UserLoginParams({
    required this.number,
  });
}
