class UserSignUpModel {
  final bool success;
  final String message;
  final UserDetails userDetails;

  UserSignUpModel({
    required this.success,
    required this.message,
    required this.userDetails,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpModel(
      success: json['success'],
      message: json['message'],
      userDetails: UserDetails.fromJson(json['userDetails']),
    );
  }
}

class UserDetails {
  final bool isNewUser;
  final String id;
  final String contact;
  final String otp;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String email;
  final String gender;
  final String name;

  UserDetails({
    required this.isNewUser,
    required this.id,
    required this.contact,
    required this.otp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.email,
    required this.gender,
    required this.name,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      isNewUser: json['is_newUser'],
      id: json['_id'],
      contact: json['contact'],
      otp: json['otp'] ?? '',
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      email: json['email'],
      gender: json['gender'],
      name: json['name'],
    );
  }
}
