
import 'package:vFASHU/features/auth/domain/model.dart';

class LoginOtpModal extends UserSendOTP{
  final bool? success;
  final String? message;

  LoginOtpModal(
      {required this.success, required this.message, required super.number});

  factory LoginOtpModal.fromJson(Map<String, dynamic> json) {
    return LoginOtpModal(
        success: json["success"]??false, message: json["message"]??'', number: json["contact"]);
  }
  // LoginOtpModal copyWith({
  //    bool? success = false;
  // String? contact;
  // String? message;
  // }) {
  //   return LoginOtpModal(
  //     id: id ?? this.id,
  //     email: email ?? this.email,
  //     name: name ?? this.name,
  //   );
  // }
}
