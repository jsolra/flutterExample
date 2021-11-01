import 'package:daangn/src/model/town_post_model.dart';
import 'package:flutter/material.dart';

// 포스트 상단 카테고리 타입 영역
Widget postCategoryType_widget(String title) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 12),
        ),
      ),
    ],
  );
}

Widget postBottomButton_widget(TownPostInfo data) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      border: Border.symmetric(
        horizontal: BorderSide(
          width: 1,
          color: Colors.blueGrey[50]!,
        ),
      ),
    ),
    child: Row(
      //하단 버튼 리스트
      children: [
        data.categoryType == townPostCategoryType.question
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '궁금해요',
                    )
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '공감하기',
                    )
                  ],
                ),
              ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Icon(
                Icons.message,
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                data.commentString,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
