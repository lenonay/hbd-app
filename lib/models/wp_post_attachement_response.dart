class WpPostAttachementResponse {
  final String url;

  WpPostAttachementResponse({required this.url});

  factory WpPostAttachementResponse.fromJson(Map<String, dynamic> json){

    return WpPostAttachementResponse(url: json["link"]);
  }
}