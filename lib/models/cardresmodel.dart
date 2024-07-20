class CartResModel {
  final bool success;
  final String message;
final Data data;
  const CartResModel({required this.success, required this.message,required this.data});

  factory CartResModel.fromJson(Map<String, dynamic> json) {
    return CartResModel(
        success: json["success"] ?? false, message: json["message"],data: Data.fromJson(json["data"]));
  }
}

class Data {
  final String userId;
  final String productId;
  final int qty;
  final bool is_invoice_created;
  final String? size;
  final String id;

  const Data(
      {required this.productId,
       this.size,
      required this.is_invoice_created,
      required this.qty,
      required this.userId,
      required this.id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        productId: json["product_id"],
        size: json["size"]??"",
        is_invoice_created: json["is_invoice_created"] ?? false,
        qty: json["qty"],
        userId: json["user_id"],
        id: json["_id"]);
  }
}
