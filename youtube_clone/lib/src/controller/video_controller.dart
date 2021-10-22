import 'package:get/get.dart';
import 'package:youtube_clone/src/api/youtube_api.dart';
import 'package:youtube_clone/src/models/statistics_model.dart';
import 'package:youtube_clone/src/models/video_model.dart';
import 'package:youtube_clone/src/models/youtuber_model.dart';

class VideoController extends GetxController {
  Video video;
  VideoController({required this.video});

  Rx<Statistics> statistics = Statistics(
          viewCount: "0",
          likeCount: "0",
          dislikeCount: "0",
          favoriteCount: "0",
          commentCount: "0")
      .obs;
  Rx<Youtuber> youtuber = Youtuber().obs;
  @override
  void onInit() async {
    Statistics? loadStatistics =
        await YoutubeApi.to.getVideoInfoById(video.id.videoId);
    if (loadStatistics != null) statistics(loadStatistics);

    Youtuber? loadYoutuber =
        await YoutubeApi.to.getChannelInfoById(video.snippet.channelId);
    if (loadYoutuber != null) youtuber(loadYoutuber);

    super.onInit();
  }

  String get viewCountString => "조회수 ${statistics.value.viewCount}회";

  String get youtuberThumbnailUrl => youtuber.value.snippet == null
      ? ''
      : youtuber.value.snippet!.thumbnails.thumbnailsDefault.url;
}
