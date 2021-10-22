import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:youtube_clone/src/controller/video_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetailController extends GetxController {
  VideoController videoController = Get.find(tag: Get.parameters["videoId"]);

  YoutubePlayerController youtubePlayerController = YoutubePlayerController(
    initialVideoId: Get.parameters["videoId"]!,
    flags: const YoutubePlayerFlags(
      mute: false,
      autoPlay: true,
      disableDragSeek: false,
      loop: false,
      isLive: false,
      forceHD: false,
      enableCaption: true,
    ),
  );

  String get title => videoController.video.snippet.title;
  String get viewCount => "조회수 ${videoController.statistics.value.viewCount}회";
  String get publishedTime => DateFormat("yyyy-MM-dd")
      .format(videoController.video.snippet.publishedAt);
  String get likeCount => videoController.statistics.value.likeCount.toString();
  String get dislikeCount =>
      videoController.statistics.value.dislikeCount.toString();

  String get description => videoController.video.snippet.description;

  String get youtuberThumbnail => videoController.youtuberThumbnailUrl;
  String get youtuberName => videoController.video.snippet.channelTitle;
  String get youtuberSubscriberCount =>
      videoController.youtuber.value.statistics == null
          ? "구독자 없음"
          : "구독자 " +
              NumberFormat("###,###,###")
                  .format(int.parse(videoController
                      .youtuber.value.statistics!.subscriberCount!))
                  .replaceAll(' ', '');
}
