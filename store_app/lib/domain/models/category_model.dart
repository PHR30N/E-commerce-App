class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? coverPictureUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.coverPictureUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      coverPictureUrl: json['coverPictureUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverPictureUrl': coverPictureUrl,
    };
  }
}