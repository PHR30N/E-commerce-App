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
      id: json['id']?.toString() ?? json['Id']?.toString() ?? '',
      name: json['name'] ?? json['Name'] ?? json['categoryName'] ?? json['CategoryName'] ?? 'Unknown',
      description: json['description'] ?? json['Description'],
      coverPictureUrl: json['coverPictureUrl'] ?? json['CoverPictureUrl'] ?? json['image'] ?? json['Image'],
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