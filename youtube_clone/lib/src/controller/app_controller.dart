import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/components/youtube_bottom_sheet_component.dart';

enum RouteName { Home, Explore, Add, Subscribe, Library }

//bottom navigation은 앱이 종료되기 전까지 유지되어야하기때문에 영속성부여
class AppController extends GetxService {
  static AppController get to => Get.find();

  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    if (RouteName.values[index] == RouteName.Add) {
      _showBottomSheet();
    } else
      currentIndex(index);
  }

  void _showBottomSheet() {
    Get.bottomSheet(YoutubeBottomSheet());
  }
}
