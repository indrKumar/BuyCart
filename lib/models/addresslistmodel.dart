class AddressListModel {
  final bool success;
  final String message;
  final AddressData data;

  AddressListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) {
    return AddressListModel(
      success: json['success'],
      message: json['message'],
      data: AddressData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class AddressData {
  final String id;
  final List<Address> address;

  AddressData({
    required this.id,
    required this.address,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) {
    return AddressData(
      id: json['_id'],
      address: (json['address'] as List<dynamic>)
          .map((item) => Address.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address.map((item) => item.toJson()).toList(),
    };
  }
}

class Address {
  final String street;
  final String city;
  final String state;
  final int zip;
  final bool isDefault;
  final String id;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.isDefault,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      isDefault: json['is_default'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'zip': zip,
      'is_default': isDefault,
      '_id': id,
    };
  }
}
