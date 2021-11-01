class TownPostInfo {
  townPostCategoryType categoryType;
  String content;
  String writer;
  String town;
  int commentCount;
  DateTime postTime;
  List<String>? imageURL;
  String? storeName;
  String? storeAddress;

  TownPostInfo(
      {required this.categoryType,
      required this.content,
      required this.writer,
      required this.town,
      required this.commentCount,
      required this.postTime,
      this.imageURL,
      this.storeName,
      this.storeAddress});

  String get category {
    switch (categoryType) {
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

  // 댓글 버튼 타이틀
  String get commentString {
    String str = '';
    switch (categoryType) {
      case townPostCategoryType.none:
      case townPostCategoryType.townInfo:
      case townPostCategoryType.ask:
      case townPostCategoryType.report:
      case townPostCategoryType.hotPlace:
        str = '댓글';
        str += commentCount == 0 ? '쓰기' : ' ' + commentCount.toString();
        break;
      case townPostCategoryType.question:
        str = '답변';
        str += commentCount == 0 ? '하기' : ' ' + commentCount.toString();
        break;
    }
    return str;
  }

  // 현재 시간과 게시글 등록 시간 비교
  String get postTimeFromNow {
    String str = '';

    Duration diff = DateTime.now().difference(postTime);

    print(diff);

    if (diff.inSeconds < 60)
      str = '${diff.inSeconds}초 전';
    else if (diff.inMinutes < 60)
      str = '${diff.inMinutes}분 전';
    else if (diff.inHours < 24)
      str = '${diff.inHours}시간 전';
    else
      str = '${diff.inDays}일 전';
    return str;
  }
}

enum townPostCategoryType { none, question, hotPlace, ask, townInfo, report }
