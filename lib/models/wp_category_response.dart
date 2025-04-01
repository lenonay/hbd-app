class WpCategoryResponse {
  final String name;
  final int id;
  final int count;

  WpCategoryResponse({
    required this.name,
    required this.id,
    required this.count,
  });

  factory WpCategoryResponse.fromJson(List<dynamic> categoryList) {
    final json = categoryList.first as Map<String, dynamic>;

    return WpCategoryResponse(
      name: json["name"],
      id: json["id"],
      count: json["count"],
    );
  }
}
