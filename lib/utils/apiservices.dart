import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/addresslistmodel.dart';
import '../models/auth/otpuser.dart';
import '../models/auth/signupmodel.dart';
import '../models/auth/usermodel.dart';
import '../models/cardresmodel.dart';
import '../models/cartdetailsmodel.dart';
import '../models/catdatamodel.dart';
import '../models/productdetailsmodel.dart';
import '../models/productlistmodel.dart';

class ApiService {
  final Dio _dio = Dio();
  String tempToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250YWN0IjoiODIyNjAzNjI4MiIsImlkIjoiNjY4Nzk5MzQyMjQ5MjE3YTgyYzRhMTBiIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjA2MTEwNzl9.GH-gvPSc8uiAo4DBNx-k4Np3tNGUhBIv7OoI-6CO3iM";

  Future<UserModel?> sendOtp({required String contactNo}) async {
    if (contactNo.length != 10) {
      return Future.error("Please enter a valid number.");
    }

    var headers = {'Content-Type': 'application/json'};
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/auth/user/login';
    var body = jsonEncode({"contact": contactNo});

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        print('Request Body: $body');
      }

      var response = await _dio.post(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return UserModel.fromJson(response.data);
      } else {
        return Future.error("Failed to send OTP. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<UserOtpModel?> verifyOtp(
      {required String contactNo, required String otp}) async {
    if (contactNo.length != 10) {
      return Future.error("Please enter a valid number.");
    }

    var headers = {'Content-Type': 'application/json'};
    var url =
        'https://vfasu-backend-node.onrender.com/api/v1/auth/user/verify-otp';
    var body = jsonEncode({"contact": contactNo, "otp": otp});

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        print('Request Body: $body');
      }

      var response = await _dio.post(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return UserOtpModel.fromJson(response.data);
      } else {
        return Future.error("Failed to send OTP. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<CatDataModel?> getCategories() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/';
    // var body = jsonEncode({
    //   "name": name,
    //   "email": gmail,
    //   "gender": gender
    // });

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        // print('Request Body: $body');
      }

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        // data: body,
      );
      if (kDebugMode) {
        print('Request Body: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return CatDataModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<ProductListModel> getProductList({String? id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url =
        'https://vfasu-backend-node.onrender.com/api/v1/app/getProductBysubCatId/$id';
    // var body = jsonEncode({
    //   "name": name,
    //   "email": gmail,
    //   "gender": gender
    // });

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        // print('Request Body: $body');
      }

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        // data: body,
      );
      if (kDebugMode) {
        print('Request Body: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return ProductListModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<ProductDetailsModel> getProductDetails({String? id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/product/$id';
    // var body = jsonEncode({
    //   "name": name,
    //   "email": gmail,
    //   "gender": gender
    // });

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        // print('Request Body: $body');
      }

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        // data: body,
      );
      if (kDebugMode) {
        print('Request Body: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return ProductDetailsModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<UserSignUpModel?> signUp(
      {required String gmail,
      required String name,
      required String gender}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url =
        'https://vfasu-backend-node.onrender.com/api/v1/auth/user/update/';
    var body = jsonEncode({"name": name, "email": gmail, "gender": gender});

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        print('Request Body: $body');
      }

      var response = await _dio.post(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        data: body,
      );
      print('Request Body: ${response.data}');

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return UserSignUpModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<CartDetailsModel?> getCart() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/cart/';

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
      }

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          // validateStatus: (status) {
          //   return status! < 500; // Accepts all responses with status code < 500
          // },
        ),
      );

      if (kDebugMode) {
        print('Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        return CartDetailsModel.fromJson(response.data);
      } else {
        return Future.error(
            "Failed to fetch cart details. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<CartResModel?> addToCart({
    String? product_id,
    int? qty,
    String? size,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/cart/add';
    var body =
        jsonEncode({"product_id": product_id, "qty": qty, "size": size ?? ''});
    try {
      var response = await _dio.post(url,
          options: Options(
            headers: headers,
          ),
          data: body);

      if (response.statusCode == 200) {
        print("Response data::::: ${response.data}");
        return CartResModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<CartResModel?> updateCart({
    String? product_id,
    int? qty,
    String? size,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/cart/add';
    var body =
        jsonEncode({"product_id": product_id, "qty": qty, "size": size ?? ''});
    try {
      var response = await _dio.post(url,
          options: Options(
            headers: headers,
          ),
          data: body);

      if (response.statusCode == 200) {
        print("Response data::::: ${response.data}");
        return CartResModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<Map<String, dynamic>> addAddress({
    String? street,
    String? city,
    String? state,
    String? pin,
    bool? isDefault,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url =
        'https://vfasu-backend-node.onrender.com/api/v1/app/address/create';
    var body = jsonEncode({
      "street": street,
      "city": city,
      "state": state,
      "zip": pin,
      "is_default": isDefault ?? false,
    });

    try {
      var response =
          await _dio.post(url, options: Options(headers: headers), data: body);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
            'Failed to add address. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error adding address: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateAddress({
    String? id,
    String? street,
    String? city,
    String? state,
    String? pin,
    bool? isDefault,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/address/$id';
    var body = jsonEncode({
      "street": street,
      "city": city,
      "state": state,
      "zip": pin,
      "is_default": isDefault ?? false,
    });

    try {
      var response =
          await _dio.put(url, options: Options(headers: headers), data: body);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
            'Failed to add address. Status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Error adding address: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }

  Future<AddressListModel> getAddressList() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/address/';

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
        // print('Request Body: $body');
      }

      var response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
        // data: body,
      );
      if (kDebugMode) {
        print('Request Body: ${response.data}');
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Response Data: ${response.data}');
        }
        return AddressListModel.fromJson(response.data);
      } else {
        return Future.error("Failed to sign up. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<Map<String, dynamic>> deleteAddress({required String id}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
    };
    var url = 'https://vfasu-backend-node.onrender.com/api/v1/app/address/$id';

    try {
      if (kDebugMode) {
        print('Request URL: $url');
        print('Request Headers: $headers');
      }

      var response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
      );

      if (kDebugMode) {
        print('Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        return Future.error(
            "Failed to delete address. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }

  Future<dynamic> deleteCart({String? productId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $tempToken",
      // 'Cookie': 'connect.sid=s%3Awv01q6Ey24NnkwUs7Z2mGDh7moX8CMDn.8JT9oEQlDFOWi1CYaJTkz4VNYO%2BHuYxhKoQNnJFSyP8',
    };

    var url =
        'https://vfasu-backend-node.onrender.com/api/v1/app/cart/delete/$productId';

    try {
      var response = await _dio.request(
        url,
        options: Options(
          method: 'GET',
          headers: headers,
          validateStatus: (status) {
            return status! <
                500; // Accepts all responses with status code < 500
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Response data::::: ${response.data}");
        return response.data;
      } else {
        return Future.error(
            "Failed to delete cart item. Please try again later.");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('An error occurred: ${e.message}');
      }
      return Future.error(e.message.toString());
    } catch (e) {
      if (kDebugMode) {
        print('An unexpected error occurred: $e');
      }
      return Future.error(
          "An unexpected error occurred. Please try again later.");
    }
  }
}
