import 'package:daangn/src/model/town_post_model.dart';
import 'package:get/get.dart';

class TownController extends GetxController {
  RxList<dynamic> postData = <TownPostInfo>[].obs;
  TownPostInfo? detailData;

  void setDetailData(TownPostInfo data) {
    detailData = data;
  }

  String getCategoryType(townPostCategoryType type) {
    switch (type) {
      case townPostCategoryType.none:
        return '';
      case townPostCategoryType.question:
        return '우리동네질문';
      case townPostCategoryType.hotPlace:
        return '동네맛집';
      case townPostCategoryType.ask:
        return '해주세요';
      case townPostCategoryType.townInfo:
        return '동네소식';
      case townPostCategoryType.report:
        return '분실/실종신고';
    }
  }
}
