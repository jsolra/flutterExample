import 'package:get/get.dart';
import 'package:youtube_clone/src/api/youtube_api.dart';
import 'package:youtube_clone/src/controller/app_controller.dart';

class initBinding implements Bindings {
  @override
  void dependencies() {
    //permanent: true 영구사용
    Get.put(YoutubeApi(), permanent: true);

    Get.put(AppController());
  }
}
