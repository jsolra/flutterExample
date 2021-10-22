import 'package:youtube_clone/src/models/video_model.dart';

class YoutubeVideoResult {
  late int totalResults;
  late int resultsPerPage;
  String? nextPageToken;
  late List<Video> items;

  YoutubeVideoResult(
      {required this.totalResults,
      required this.resultsPerPage,
      this.nextPageToken,
      required this.items});

  factory YoutubeVideoResult.fromJson(Map<String, dynamic> json) =>
      YoutubeVideoResult(
          totalResults: json["pageInfo"]["totalResults"],
          resultsPerPage: json["pageInfo"]["resultsPerPage"],
          nextPageToken: json["nextPageToken"] ?? "",
          items: List<Video>.from(
              json["items"].map((data) => Video.fromJson(data))));
}
