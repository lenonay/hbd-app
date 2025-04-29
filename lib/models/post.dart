class Post {
  final int id;
  final String date;
  final String title;
  final String content;
  final String? bannerURL;
  final List media;

  Post({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.bannerURL,
    required this.media,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final att = List.from(json["attachments"]);

    final banner = (att.isNotEmpty) ? att[0]["url"] : null;

    return Post(
      id: json["id"],
      date: json["date"],
      title: json["title"],
      content: json["content"],
      bannerURL: banner,
      media: att,
    );
  }
}
