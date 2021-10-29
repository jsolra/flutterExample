import 'dart:convert';

import 'package:daangn/src/controller/app_controller.dart';
// import 'package:daangn/src/repository/local_storage_repository.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  // DetailController detailController = Get.find(tag: Get.parameters["cid"]);
  RxBool isMyFavoriteContent = false.obs;

  List<dynamic> favoriteContentList = [];

  @override
  void onInit() {
    favoriteContentList = AppController.to.favoriteContentList;
  }

  //즐겨찾기 추가
  addMyFavoriteContent(Map<String, dynamic> content) async {
    isMyFavoriteContent(!isMyFavoriteContent.value);
    if (favoriteContentList == [] || !(favoriteContentList is List)) {
      favoriteContentList = [content];
    } else
      favoriteContentList.add(content);

    AppController.to.updateFavoriteContent(favoriteContentList);
  }

  //즐겨찾기 삭제
  deleteFavoriteContent(String cid) async {
    isMyFavoriteContent(!isMyFavoriteContent.value);
    if (favoriteContentList != [] && (favoriteContentList is List)) {
      favoriteContentList.removeWhere((data) => data['cid'] == cid);
    }
    AppController.to.updateFavoriteContent(favoriteContentList);
  }

  //즐겨찾기 여부
  Future<bool> isMyFavoriteContents(String cid) async {
    bool ismyFavoriteContents = false;

    if (favoriteContentList == [] || !(favoriteContentList is List)) {
      return false;
    } else {
      for (dynamic data in favoriteContentList) {
        if (data['cid'] == cid) {
          ismyFavoriteContents = true;
          break;
        }
      }
      return ismyFavoriteContents;
    }
  }
}
