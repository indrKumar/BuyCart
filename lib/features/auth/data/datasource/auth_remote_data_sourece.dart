import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../../../../error/exceptions.dart';
import '../../../../error/failures.dart';
import '../models/loginotpmodal.dart';

abstract interface class AuthRemoteDataSource {
  // Future<LoginOtpModal> signUpWithEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // });
  Future<LoginOtpModal> loginWithEmailPassword({
    required String number,
  });
  // Future<LoginOtpModal?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client? _httpClient;
  final Dio? _dioClient;

  AuthRemoteDataSourceImpl(this._httpClient, this._dioClient);

  @override
  Future<LoginOtpModal> loginWithEmailPassword({
    required String number,
  }) async {
    print("DATA SURCE");
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse('https://your-api-endpoint.com/auth/user/login'));
      request.body = json.encode({
        "contact": number,
      });
      request.headers.addAll(headers);
      log("NUMBER:::$number");
      http.StreamedResponse response = await request.send();
      print("RESPONEE:::${response}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return LoginOtpModal.fromJson(json.decode(responseBody));
      } else {
        throw const ServerException('Login failed');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
// @override
// Future<UserModel> signUpWithEmailPassword({
//   required String name,
//   required String email,
//   required String password,
// }) async {
//   try {
//     final response = await _httpClient?.post(
//       Uri.parse('https://your-api-endpoint.com/signup'),
//       body: {
//         'name': name,
//         'email': email,
//         'password': password,
//       },
//     );
//     if (response?.statusCode == 200) {
//       return UserModel.fromJson(response?.body as Map<String, dynamic>);
//     } else {
//       throw ServerException('Sign up failed');
//     }
//   } catch (e) {
//     throw ServerException(e.toString());
//   }
// }
//
// @override
// Future<UserModel?> getCurrentUserData() async {
//   try {
//     final response = await _httpClient.get(
//       Uri.parse('https://your-api-endpoint.com/user'),
//       headers: {
//         'Authorization': 'Bearer your-access-token',
//       },
//     );
//     if (response.statusCode == 200) {
//       return UserModel.fromJson(response.body);
//     } else {
//       return null;
//     }
//   } catch (e) {
//     throw ServerException(e.toString());
//   }
// }
}
