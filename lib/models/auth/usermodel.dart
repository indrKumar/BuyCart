class UserModel {
  final bool success;
  final String message;
  final Data data;

  UserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final String contact;

  Data({required this.contact});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      contact: json['contact'],
    );
  }
}
