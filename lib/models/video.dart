class Video {
  final String id;
  final String title;
  final String thumbnail;
  final String channel;

  Video({this.id, this.title, this.thumbnail, this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      return Video(
        id: json["id"]["videoId"],
        title: json["snippet"]["title"],
        thumbnail: json["snippet"]["thumbnails"]["high"]["url"],
        channel: json["snippet"]["channelTitle"],
      );
    } else {
      return Video(
        id: json["videoId"],
        title: json["title"],
        thumbnail: json["thumb"],
        channel: json["channel"],
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": this.id,
      "title": this.title,
      "thumb": this.thumbnail,
      "channel": this.channel
    };
  }
}
