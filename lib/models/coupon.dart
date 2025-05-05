class Coupon {
  final String title;
  final String content;

  Coupon({required this.title, required this.content});

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(title: json["title"], content: json["content"]);
  }
}
