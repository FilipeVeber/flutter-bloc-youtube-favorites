class Video {
  final String id;
  final String title;
  final String thumbnail;
  final String channel;

  Video({this.id, this.title, this.thumbnail, this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json["id"]["videoId"],
      title: json["snippet"]["title"],
      thumbnail: json["snippet"]["thumbnails"]["high"]["url"],
      channel: json["snippet"]["channelTitle"],
    );
  }
}
