import 'package:get/get.dart';
import 'package:youtube_clone/src/models/statistics_model.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';
import 'package:youtube_clone/src/models/youtuber_model.dart';

class YoutubeApi extends GetConnect {
  static YoutubeApi get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = 'https://www.googleapis.com';
    super.onInit();
  }

  Future<YoutubeVideoResult?> loadVideos() async {
    String url =
        '/youtube/v3/search?part=snippet&channelId=UCbMGBIayK26L4VaFrs5jyBw&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyCbvcjZGFG59ck3ksHh-v9jzKzCoz_A-ng';
    final response = await get(url);

    if (response.status.hasError)
      return Future.error(response.statusText!);
    else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<YoutubeVideoResult?> getSearch(
      String searchKeyword, String nextPageToken) async {
    String url =
        '/youtube/v3/search?part=snippet&maxResults=10&order=date&type=video&videoDefinition=high&key=AIzaSyCbvcjZGFG59ck3ksHh-v9jzKzCoz_A-ng&pageToken=$nextPageToken&q=$searchKeyword';
    final response = await get(url);

    if (response.status.hasError)
      return Future.error(response.statusText!);
    else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  Future<Statistics?> getVideoInfoById(String VideoId) async {
    String url =
        '/youtube/v3/videos?part=statistics&key=AIzaSyCbvcjZGFG59ck3ksHh-v9jzKzCoz_A-ng&id=$VideoId';
    final response = await get(url);

    if (response.status.hasError)
      return Future.error(response.statusText!);
    else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Statistics.fromJson(data["statistics"]);
      }
    }
  }

  Future<Youtuber?> getChannelInfoById(String channelId) async {
    String url =
        '/youtube/v3/channels?part=statistics,snippet&key=AIzaSyCbvcjZGFG59ck3ksHh-v9jzKzCoz_A-ng&id=$channelId';
    final response = await get(url);

    if (response.status.hasError)
      return Future.error(response.statusText!);
    else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Youtuber.fromJson(data);
      }
    }
  }
}
