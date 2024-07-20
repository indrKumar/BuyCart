class ProductDetailsModel {
  final bool success;
  final String message;
  final ProductData data;

  ProductDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      success: json['success'],
      message: json['message'],
      data: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final Product products;

  ProductData({
    required this.products,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      products: Product.fromJson(json['products']),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String content;
  final String status;
  final List<String> images;
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
  final List<Category> categories;
  final List<String> productCollectionsId;
  final bool isIndex;
  final String createdAt;
  final String updatedAt;
  final int v;

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
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      description: json['description'],
      content: json['content'],
      status: json['status'],
      images: List<String>.from(json['images']),
      cost: json['cost'],
      stockStatus: json['stock_status'],
      faqs: (json['faqs'] as List<dynamic>).map((faq) => Faq.fromJson(faq)).toList(),
      isFeatured: json['is_featured'],
      seoTitle: json['seo_title'],
      seoDescription: json['seo_description'],
      tag: json['tag'],
      minOrder: json['min_order'],
      maxOrder: json['max_order'],
      taxesTypes: List<String>.from(json['taxes_types']),
      labels: List<String>.from(json['labels']),
      brandId: json['brand_id'],
      categories: (json['categories'] as List<dynamic>).map((category) => Category.fromJson(category)).toList(),
      productCollectionsId: List<String>.from(json['product_collections_id']),
      isIndex: json['is_index'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
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
}

class Category {
  final String categId;
  final List<String> subCatId;
  final String id;

  Category({
    required this.categId,
    required this.subCatId,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categId: json['categ_id'],
      subCatId: List<String>.from(json['sub_cat_id']),
      id: json['_id'],
    );
  }
}
