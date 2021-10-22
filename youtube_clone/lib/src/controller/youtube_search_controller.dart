import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_clone/src/api/youtube_api.dart';
import 'package:youtube_clone/src/models/youtube_video_result.dart';

class YoutubeSearchController extends GetxController {
  String key = 'searchKey';
  RxList<String> history = RxList<String>.empty(growable: true);
  late SharedPreferences _profs;

  ScrollController scrollController = ScrollController();
  String currentKeyword = '';

  Rx<YoutubeVideoResult> youtubeVideoResult = YoutubeVideoResult(
      totalResults: 0, resultsPerPage: 0, nextPageToken: '', items: []).obs;

  // set을 통한 중복 확인
  // late Set<String> originHistory = {};
  @override
  void onInit() async {
    _event();

    _profs = await SharedPreferences.getInstance();
    List<String> initData = _profs.getStringList(key) ?? [];

    // set을 통한 중복 확인
    // originHistory.addAll(initData.map((_) => _.toString()).toList());
    // history(originHistory.toList());

    history(initData.map((_) => _.toString()).toList());
    // history(initData);

    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeVideoResult.value.nextPageToken != '')
        _searchYoutube(currentKeyword);
    });
  }

  void submitSearch(String searchKeyword) {
    currentKeyword = searchKeyword;
    history.addIf(!history.contains(searchKeyword), searchKeyword);
    _profs.setStringList(key, history.toList());
    _searchYoutube(searchKeyword);
    // set을 통한 중복 확인
    // history.clear();
    // originHistory.add(search);

    // history.addAll(originHistory.toList());
    // profs.setStringList(key, originHistory.toList());
  }

  void _searchYoutube(String searchKeyword) async {
    YoutubeVideoResult? youtubeVideoResultFromServer = await YoutubeApi.to
        .getSearch(searchKeyword, youtubeVideoResult.value.nextPageToken ?? "");
    if (youtubeVideoResult != null)
    // youtubeVideoResult(youtubeVideoResultFromServer);

    if (youtubeVideoResultFromServer != null &&
        youtubeVideoResultFromServer.items != null &&
        youtubeVideoResultFromServer.items.length > 0) {
      youtubeVideoResult.update((data) {
        data!.nextPageToken = youtubeVideoResultFromServer.nextPageToken;
        data!.items.addAll(youtubeVideoResultFromServer.items);
      });
      // youtubeResult(youtubeVideoResult);
    }
  }
}
