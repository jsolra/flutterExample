import 'package:intl/intl.dart';

class DataUtils {
  static DataUtils get to => DataUtils();
  final oCcy = new NumberFormat("#,###", "ko_KR");

  String calcStringToWon(String price) {
    if (price == "무료나눔")
      return '무료나눔';
    else
      return "${oCcy.format(int.parse(price))}원";
  }
}
