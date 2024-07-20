class UserOtpModel {
  final bool success;
  final String message;
  final Data data;
  final String token;

  UserOtpModel({
    required this.success,
    required this.message,
    required this.data,
    required this.token,
  });

  factory UserOtpModel.fromJson(Map<String, dynamic> json) {
    return UserOtpModel(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
      token: json['token'],
    );
  }
}

class Data {
  final String id;
  final String contact;
  final bool is_newUser;
  final String otp;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int v;

  Data({
    this.is_newUser = true,
    required this.id,
    required this.contact,
    required this.otp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      contact: json['contact'],
      otp: json['otp'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'], is_newUser: json["is_newUser"],
    );
  }
}
