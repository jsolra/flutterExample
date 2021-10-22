import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/api/youtube_api.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(
      totalResults: 0, resultsPerPage: 0, nextPageToken: '', items: []).obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    _videoLoad();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPageToken != '') _videoLoad();
    });
  }

  void _videoLoad() async {
    YoutubeVideoResult? youtubeVideoResult = await YoutubeApi.to.loadVideos();

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((data) {
        data!.nextPageToken = youtubeVideoResult.nextPageToken;
        data!.items.addAll(youtubeVideoResult.items);
      });
      // youtubeResult(youtubeVideoResult);
    } else
      print('youtube Video Result is NULL');
  }
}
