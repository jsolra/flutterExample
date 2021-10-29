import 'dart:ffi';

import 'package:daangn/src/component/appbar_widget.dart';
import 'package:flutter/material.dart';

class TownLifePage extends StatelessWidget {
  TownLifePage({Key? key}) : super(key: key);

  final List<String> categoryTypeList = [
    '우리동네질문',
    '동네맛집',
    '해주세요',
    '동네소식',
    '분실/실종신고'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.blueGrey[50],
            alignment: Alignment.center,
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: categoryTypeList.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return _categoryTypeButton(categoryTypeList[index]);
              },
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _postCategoryType('우리동네질문'),
                          ],
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                              text: 'Q. ',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        '혹시 군자동 부근에 일본인 유학생 분이나 일본어 전공하신 분 계실까요? 일본어 자문 구하려고 합니다!',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal)),
                              ]),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '냥냥아빠 · 군자동',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '59초 전',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                  color: Colors.blueGrey[50],
                  height: 1,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.message,
                            size: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '답변하기',
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                  ],
                ),
                Container(
                  color: Colors.blueGrey[50],
                  height: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryTypeButton(String title) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[400]!)),
        child: Text(title),
      ),
    );
  }

  Widget _postCategoryType(String title) {
    return Container(
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
    );
  }
}
