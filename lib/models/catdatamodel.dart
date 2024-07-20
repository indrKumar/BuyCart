class CatDataModel {
  final bool success;
  final String message;
  final Data data;

  CatDataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CatDataModel.fromJson(Map<String, dynamic> json) {
    return CatDataModel(
      success: json['success'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Category> categories;
  final List<dynamic> collections;

  Data({
    required this.categories,
    required this.collections,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var categoriesList = json['categories'] as List;
    List<Category> categories =
        categoriesList.map((i) => Category.fromJson(i)).toList();

    return Data(
      categories: categories,
      collections: json['collections'],
    );
  }
}

class Category {
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
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<Subcategory> subcategories;

  Category({
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
    required this.v,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var subcategoriesList = json['subcategories'] as List;
    List<Subcategory> subcategories =
        subcategoriesList.map((i) => Subcategory.fromJson(i)).toList();

    return Category(
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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      subcategories: subcategories,
    );
  }
}

class Subcategory {
  final String id;
  final String name;
  final String categId;
  final String createdAt;
  final String updatedAt;
  final int v;

  Subcategory({
    required this.id,
    required this.name,
    required this.categId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['_id'],
      name: json['name'],
      categId: json['categ_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
