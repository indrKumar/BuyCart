import 'package:flutter/foundation.dart';

class ProductListModel {
  final bool success;
  final String message;
  final Data data;

  ProductListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
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

class Data {
  final List<Product> products;
  final CatDetails catDetails;
  final SubCatDetails subCatDetails;

  Data({
    required this.products,
    required this.catDetails,
    required this.subCatDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
      catDetails: CatDetails.fromJson(json['CatDetails']),
      subCatDetails: SubCatDetails.fromJson(json['subCatDetails']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
      'CatDetails': catDetails.toJson(),
      'subCatDetails': subCatDetails.toJson(),
    };
  }
}

class Product {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String content;
  final String status;
  final List<dynamic> images;
  final String cost;
  final String stockStatus;
  final List<Faq> faqs;
  final bool isFeatured;
  final String seoTitle;
  final String seoDescription;
  final String tag;
  final int minOrder;
  final int maxOrder;
  final List<String> taxesTypes;
  final List<String> labels;
  final String brandId;
  final List<Cat> categories;
  final List<dynamic> productCollectionsId;
  final bool isIndex;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.content,
    required this.status,
    required this.images,
    required this.cost,
    required this.stockStatus,
    required this.faqs,
    required this.isFeatured,
    required this.seoTitle,
    required this.seoDescription,
    required this.tag,
    required this.minOrder,
    required this.maxOrder,
    required this.taxesTypes,
    required this.labels,
    required this.brandId,
    required this.categories,
    required this.productCollectionsId,
    required this.isIndex,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      content: json['content'],
      status: json['status'],
      images: List<dynamic>.from(json['images']),
      cost: json['cost'],
      stockStatus: json['stock_status'],
      faqs: List<Faq>.from(json['faqs'].map((x) => Faq.fromJson(x))),
      isFeatured: json['is_featured'],
      seoTitle: json['seo_title'],
      seoDescription: json['seo_description'],
      tag: json['tag'],
      minOrder: json['min_order'],
      maxOrder: json['max_order'],
      taxesTypes: List<String>.from(json['taxes_types']),
      labels: List<String>.from(json['labels']),
      brandId: json['brand_id'],
      categories: List<Cat>.from(json['categories'].map((x) => Cat.fromJson(x))),
      productCollectionsId: List<dynamic>.from(json['product_collections_id']),
      isIndex: json['is_index'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'content': content,
      'status': status,
      'images': List<dynamic>.from(images),
      'cost': cost,
      'stock_status': stockStatus,
      'faqs': List<dynamic>.from(faqs.map((x) => x.toJson())),
      'is_featured': isFeatured,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'tag': tag,
      'min_order': minOrder,
      'max_order': maxOrder,
      'taxes_types': List<dynamic>.from(taxesTypes),
      'labels': List<dynamic>.from(labels),
      'brand_id': brandId,
      'categories': List<dynamic>.from(categories.map((x) => x.toJson())),
      'product_collections_id': List<dynamic>.from(productCollectionsId),
      'is_index': isIndex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Faq {
  final String question;
  final String answer;
  final String id;

  Faq({
    required this.question,
    required this.answer,
    required this.id,
  });

  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      question: json['question'],
      answer: json['answer'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      '_id': id,
    };
  }
}

class Cat {
  final String categId;
  final List<String> subCatId;
  final String id;

  Cat({
    required this.categId,
    required this.subCatId,
    required this.id,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      categId: json['categ_id'],
      subCatId: List<String>.from(json['sub_cat_id']),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categ_id': categId,
      'sub_cat_id': List<dynamic>.from(subCatId),
      '_id': id,
    };
  }
}

class CatDetails {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String status;
  final String fontIcon;
  final bool isFeatured;
  final String seoTitle;
  final String seoDescription;
  final bool isIndex;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  CatDetails({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.status,
    required this.fontIcon,
    required this.isFeatured,
    required this.seoTitle,
    required this.seoDescription,
    required this.isIndex,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory CatDetails.fromJson(Map<String, dynamic> json) {
    return CatDetails(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      status: json['status'],
      fontIcon: json['font_icon'],
      isFeatured: json['is_featured'],
      seoTitle: json['seo_title'],
      seoDescription: json['seo_description'],
      isIndex: json['is_index'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'status': status,
      'font_icon': fontIcon,
      'is_featured': isFeatured,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'is_index': isIndex,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class SubCatDetails {
  final String id;
  final String name;
  final String categId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  SubCatDetails({
    required this.id,
    required this.name,
    required this.categId,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory SubCatDetails.fromJson(Map<String, dynamic> json) {
    return SubCatDetails(
      id: json['_id'],
      name: json['name'],
      categId: json['categ_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'categ_id': categId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}
