class Video {
  final String id;
  final String title;
  final String thumb;
  final String channel;

  Video(
      {required this.id,
      required this.title,
      required this.thumb,
      required this.channel});

  factory Video.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("id")) {
      return Video(
          id: json['id']['videoId'],
          title: json['snippet']['title'],
          thumb: json['snippet']['thumbnails']['high']['url'],
          channel: json['snippet']['channelTitle']);
    } else {
      return Video(
          id: json['id'],
          title: json['title'],
          thumb: json['thumb'],
          channel: json['channel']);
    }
  }

  Map<String, dynamic> toJSON() {
    return {
      "videoId": id,
      "title": title,
      "thumb": thumb,
      "channel": channel,
    };
  }
}
