import '../../../../error/failures.dart';
import '../../data/models/loginotpmodal.dart';
import '../model.dart';
import 'package:fpdart/fpdart.dart';

//
// abstract interface class AuthRepository {
//   // Future<Either<Failure, UserSendOTP>> signUpWithEmailPassword({
//   //   required String name,
//   //   required String email,
//   //   required String password,
//   // });
//   Future<Either<Failure, UserSendOTP>> loginWithEmailPassword({
//     required String number,
//     // required String password,
//   });
//   // Future<Either<Failure, UserSendOTP>> currentUser();
// }
abstract interface class AuthRepository {
  Future<Either<Failure, UserSendOTP>> loginWithEmailPassword({
    required String number,
  });
}
