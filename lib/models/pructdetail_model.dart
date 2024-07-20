// class ProductList {
//   final String productId;
//   final String name;
//   final String sku;
//   final String productType;
//   final List<String> image;
//   final String oldPrice;
//   final String price;
//   final String brand;
//
//   ProductList({
//     required this.productId,
//     required this.name,
//     required this.sku,
//     required this.productType,
//     required this.image,
//     required this.oldPrice,
//     required this.price,
//     required this.brand,
//   });
//   factory ProductList.fromJson(Map<String, dynamic> json) {
//     return ProductList(
//       productId: json['product_id'],
//       name: json['name'],
//       sku: json['sku'],
//       productType: json['product_type'],
//       image: List<String>.from(json['image']),
//       oldPrice: json['old_price'],
//       price: json['price'],
//       brand: json['brand'],
//     );
//   }
// }
//
