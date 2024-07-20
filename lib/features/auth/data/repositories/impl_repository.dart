
import 'dart:developer';

import '../../../../error/exceptions.dart';
import '../../../../error/failures.dart';
import '../../../../network/connection_checker.dart';
import '../../../../utils/utils.dart';
import '../../domain/model.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_data_sourece.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(
      this.remoteDataSource,
      this.connectionChecker,
      );

  @override
  Future<Either<Failure, UserSendOTP>> loginWithEmailPassword({required String number}) {
    print("object");
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  // @override
  // Future<Either<Failure, UserSendOTP>> currentUser() async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       final session = remoteDataSource.currentUserSession;
  //
  //       if (session == null) {
  //         return left(Failure('User not logged in!'));
  //       }
  //
  //       return right(
  //         UserModel(
  //           id: session.user.id,
  //           email: session.user.email ?? '',
  //           name: '',
  //         ),
  //       );
  //     }
  //     final user = await remoteDataSource.getCurrentUserData();
  //     if (user == null) {
  //       return left(Failure('User not logged in!'));
  //     }
  //
  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }



  //
  // @override
  // Future<Future<Either<Failure, UserSendOTP>>> loginWithEmailPassword({
  //   required String number,
  // }) async {
  //   return _getUser(
  //         () async => await remoteDataSource.loginWithEmailPassword(
  //       number: number,
  //     ),
  //   );
  // }
  //
  // @override
  // Future<Either<Failure, User>> signUpWithEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   return _getUser(
  //         () async => await remoteDataSource.signUpWithEmailPassword(
  //       name: name,
  //       email: email,
  //       password: password,
  //     ),
  //   );
  // }
  //
  // Future<Either<Failure, UserSendOTP>> _getUser(
  //     Future<UserSendOTP> Function() fn,
  //     ) async {
  //   try {
  //     if (!await (connectionChecker.isConnected)) {
  //       return left(Failure(Constants.noConnectionErrorMessage));
  //     }
  //     final user = await fn();
  //
  //     return right(user);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }
}
