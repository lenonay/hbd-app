class Post {
  final int id;
  final String date;
  final String title;
  final String content;
  final String? bannerURL;
  final List<String> media;

  Post({
    required this.id,
    required this.date,
    required this.title,
    required this.content,
    required this.bannerURL,
    required this.media,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final att = List<String>.from(json["attachments"]);

    final banner = (att.isNotEmpty) ? att[0] : null;

    final date = formatDate(json["date"]); // Formatemaos la fecha

    return Post(
      id: json["id"],
      date: date,
      title: json["title"],
      content: json["content"],
      bannerURL: banner,
      media: att,
    );
  }
}

String formatDate(String unFormattedDate) {
  // Formatearemos la fecha entendiendo que llegue de la siguente forma
  // yyyy-mm-dd HH:MM:SS
  final array = unFormattedDate.split(" ");

  final date = array[0];
  final time = array[1];

  // Le damos la vuelta y usamos / en lugar de -
  final formattedDate = date.split("-").reversed.join("/");

  // Nos quedamos con la hora y los minutos
  final formattedTime = time.split(":").sublist(0,2).join(":");

  // Retornamos la fecha formateada.
  return '$formattedDate $formattedTime';
}
