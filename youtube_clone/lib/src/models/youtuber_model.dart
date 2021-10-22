import 'package:youtube_clone/src/models/statistics_model.dart';
import 'package:youtube_clone/src/models/video_model.dart';

class Youtuber {
  Youtuber({this.snippet, this.statistics});

  Snippet? snippet;
  Statistics? statistics;

  factory Youtuber.fromJson(Map<String, dynamic> json) => Youtuber(
        snippet: Snippet.fromJson(json["snippet"]),
        statistics: Statistics.fromJson(json["statistics"]),
      );
}
