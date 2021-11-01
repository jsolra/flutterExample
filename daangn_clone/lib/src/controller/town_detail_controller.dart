import 'package:daangn/src/model/town_post_model.dart';
import 'package:get/get.dart';

class TownLifeDetailController extends GetxController {
  RxBool SortNewest = false.obs;

  setSort(bool type) {
    SortNewest(type);
  }
}
