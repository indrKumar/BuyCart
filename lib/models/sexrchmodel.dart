class searchModel {
  int? status;
  String? message;
  List<Data>? data;

  searchModel({this.status, this.message, this.data});

  searchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? productId;
  String? name;
  String? sku;
  String? productType;
  List<String>? image;
  String? oldPrice;
  String? price;
  String? brand;
  List<ChildProducts>? childProducts;

  Data(
      {this.productId,
        this.name,
        this.sku,
        this.productType,
        this.image,
        this.oldPrice,
        this.price,
        this.brand,
        this.childProducts});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'];
    sku = json['sku'];
    productType = json['product_type'];
    image = json['image'].cast<String>();
    oldPrice = json['old_price'];
    price = json['price'];
    brand = json['brand'];
    if (json['child_products'] != null) {
      childProducts = <ChildProducts>[];
      json['child_products'].forEach((v) {
        childProducts!.add(new ChildProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['sku'] = this.sku;
    data['product_type'] = this.productType;
    data['image'] = this.image;
    data['old_price'] = this.oldPrice;
    data['price'] = this.price;
    data['brand'] = this.brand;
    if (this.childProducts != null) {
      data['child_products'] =
          this.childProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildProducts {
  String? sku;
  String? oldPrice;
  String? price;

  ChildProducts({this.sku, this.oldPrice, this.price});

  ChildProducts.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    oldPrice = json['old_price'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sku'] = this.sku;
    data['old_price'] = this.oldPrice;
    data['price'] = this.price;
    return data;
  }
}