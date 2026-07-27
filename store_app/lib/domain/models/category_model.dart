class CategoryModel {
  final String name;
  final String iconAsset; // maps a category name to a local icon in the UI
  final String? imageUrl; // optional image coming from the API

  CategoryModel({
    required this.name,
    required this.iconAsset,
    this.imageUrl,
  });

  /// Builds a CategoryModel from the raw string returned by the
  /// categories API (e.g. FakeStore API returns a list of plain strings).
  factory CategoryModel.fromApiString(String raw) {
    return CategoryModel(
      name: _titleCase(raw),
      iconAsset: _iconFor(raw),
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? 'Unknown',
      iconAsset: _iconFor(json['name'] ?? ''),
      imageUrl: json['image'],
    );
  }

  static String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s
        .split(' ')
        .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }

  // Very small heuristic so unseen category names still get a sensible icon.
  static String _iconFor(String raw) {
    final s = raw.toLowerCase();
    if (s.contains('groc') || s.contains('food')) return 'groceries';
    if (s.contains('appliance') || s.contains('electronic')) {
      return 'appliances';
    }
    if (s.contains('cloth') || s.contains('fashion') || s.contains('wear')) {
      return 'fashion';
    }
    if (s.contains('furni') || s.contains('home')) return 'furniture';
    return 'default';
  }
}
