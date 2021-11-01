import 'package:daangn/src/component/appbar_widget.dart';
import 'package:daangn/src/controller/town_controller.dart';
import 'package:daangn/src/model/town_post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TownLifePage extends GetView<TownController> {
  TownLifePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    Get.lazyPut(() => TownController());
    controller.postData.add(TownPostInfo(
        categoryType: townPostCategoryType.question,
        content: '안녕하세요 반갑습니다. 테스트용 게시글입니다. 반가워요 네네. ',
        writer: '김테스터',
        town: '성수동1가',
        imageURL: [
          'assets/images/towns/tw_img1.jpg',
          'assets/images/towns/tw_img2.jpg',
          'assets/images/towns/tw_img5.jpg',
        ],
        commentCount: 52,
        postTime: DateTime(2021, 11, 01, 13, 38, 55)));

    controller.postData.add(TownPostInfo(
        categoryType: townPostCategoryType.hotPlace,
        content:
            '핫플레이스 게시글 테스트입니다. 맛있어요 짱 최고 굿굿굿\n핫플레이스 게시글 테스트입니다. 맛있어요 짱 최고 굿굿굿\n핫플레이스 게시글 테스트입니다. 맛있어요 짱 최고 굿굿굿\n ',
        writer: 'dkfoscidfl1238',
        town: '군자동',
        commentCount: 0,
        postTime: DateTime(2021, 11, 01, 6, 5, 55)));

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.blueGrey[50],
              alignment: Alignment.center,
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: townPostCategoryType.values.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return _categoryTypeButton(
                      townPostCategoryType.values[index]);
                },
              ),
            ),
            _postContent(TownPostInfo(
                categoryType: townPostCategoryType.question,
                content:
                    '님들 성수동 토박인데 요즘도 아니고 근 몇개월간 오토바이 소리 너무 시끄럽지 않나요? 이거 민원이라도 넣으면 해결되려나요',
                writer: '아아아아',
                town: '성수동1가',
                imageURL: [
                  'assets/images/towns/tw_img6.jpg',
                ],
                commentCount: 0,
                postTime: DateTime(2021, 11, 01, 15, 26, 55))),
            _postContent(TownPostInfo(
                categoryType: townPostCategoryType.hotPlace,
                content: '안녕하세요 반갑습니다. 테스트용 게시글입니다. 반가워요. 연습용입니다. ',
                writer: '김테스터',
                town: '성수동1가',
                imageURL: [
                  'assets/images/towns/tw_img1.jpg',
                  'assets/images/towns/tw_img2.jpg',
                  'assets/images/towns/tw_img3.jpg',
                  'assets/images/towns/tw_img4.jpg',
                  'assets/images/towns/tw_img5.jpg',
                  'assets/images/towns/tw_img6.jpg',
                  'assets/images/towns/tw_img7.jpg',
                ],
                storeAddress: '서울특별시 성동구 광나루로 204',
                storeName: '제뉴인카앤파츠',
                commentCount: 52,
                postTime: DateTime(2021, 11, 01, 13, 38, 55))),

            /*
            // Container(
            //   child: Column(
            //     children: [
            //       Container(
            //           padding: const EdgeInsets.all(15),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: [
            //               Row(
            //                 //상단 카테고리 타입
            //                 children: [
            //                   _postCategoryType('우리동네질문'),
            //                 ],
            //               ),
            //               SizedBox(height: 10),
            //               RichText(
            //                 //본문 텍스트
            //                 text: TextSpan(
            //                     text: 'Q. ',
            //                     style: TextStyle(
            //                         color: Colors.orange,
            //                         fontWeight: FontWeight.bold),
            //                     children: <TextSpan>[
            //                       TextSpan(
            //                           text:
            //                               '혹시 군자동 부근에 일본인 유학생 분이나 일본어 전공하신 분 계실까요? 일본어 자문 구하려고 합니다!',
            //                           style: TextStyle(
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.normal)),
            //                       TextSpan(
            //                           recognizer: MultiTapGestureRecognizer()
            //                             ..onTap = (a) {
            //                               print('touch $a');
            //                             },
            //                           text: '더보기',
            //                           style: TextStyle(
            //                             color: Colors.grey,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 10,
            //                           )),
            //                     ]),
            //               ),
            //               SizedBox(height: 30),
            //               Row(
            //                 //게시글 작성 정보
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     '냥냥아빠 · 군자동',
            //                     style:
            //                         TextStyle(fontSize: 12, color: Colors.grey),
            //                   ),
            //                   Text(
            //                     '59초 전',
            //                     style:
            //                         TextStyle(fontSize: 12, color: Colors.grey),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           )),
            //       Container(
            //         color: Colors.blueGrey[50],
            //         height: 1,
            //       ),
            //       Row(
            //         //하단 버튼 리스트
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.check_circle_outlined,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '궁금해요',
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.smart_toy_outlined,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '공감하기',
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.message,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '답변하기',
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(
            //         color: Colors.blueGrey[50],
            //         height: 10,
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Column(
            //     children: [
            //       Container(
            //           padding: const EdgeInsets.all(15),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.stretch,
            //             children: [
            //               Row(
            //                 //상단 카테고리 타입
            //                 children: [
            //                   _postCategoryType('동네맛집'),
            //                 ],
            //               ),
            //               SizedBox(height: 10),
            //               RichText(
            //                 //본문 텍스트
            //                 text: TextSpan(
            //                     text: '',
            //                     style: TextStyle(
            //                         color: Colors.orange,
            //                         fontWeight: FontWeight.bold),
            //                     children: <TextSpan>[
            //                       TextSpan(
            //                           text: '성수동에서 일식은 윤경입니다',
            //                           style: TextStyle(
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.normal)),
            //                       TextSpan(
            //                           recognizer: MultiTapGestureRecognizer()
            //                             ..onTap = (a) {
            //                               print('touch $a');
            //                             },
            //                           text: '더보기',
            //                           style: TextStyle(
            //                             color: Colors.grey,
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 10,
            //                           )),
            //                     ]),
            //               ),
            //               SizedBox(height: 10),
            //               _imageList([
            //                 'assets/images/towns/tw_img5.jpg',
            //                 'assets/images/towns/tw_img6.jpg',
            //               ]),
            //               SizedBox(height: 15),
            //               Container(
            //                 height: 70,
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   border: Border.all(
            //                     width: 1,
            //                     color: Colors.blueGrey,
            //                     // color: Colors.blueGrey[50]!,
            //                   ),
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Container(
            //                       width: 70,
            //                       decoration: BoxDecoration(
            //                           color: Colors.lightGreen,
            //                           borderRadius: BorderRadius.only(
            //                             topLeft: Radius.circular(10),
            //                             bottomLeft: Radius.circular(10),
            //                           )),
            //                     ),
            //                     SizedBox(width: 15),
            //                     Expanded(
            //                       child: Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.stretch,
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [
            //                           Text(
            //                             '윤경 성수동',
            //                             style: TextStyle(fontSize: 12),
            //                           ),
            //                           Text(
            //                             '서울특별시 성동구 아차산로 3 (성수동1가)',
            //                             style: TextStyle(
            //                                 fontSize: 10, color: Colors.grey),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(height: 30),
            //               Row(
            //                 //게시글 작성 정보
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Text(
            //                     '냥냥아빠 · 군자동',
            //                     style:
            //                         TextStyle(fontSize: 12, color: Colors.grey),
            //                   ),
            //                   Text(
            //                     '59초 전',
            //                     style:
            //                         TextStyle(fontSize: 12, color: Colors.grey),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           )),
            //       Container(
            //         color: Colors.blueGrey[50],
            //         height: 1,
            //       ),
            //       Row(
            //         //하단 버튼 리스트
            //         children: [
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.check_circle_outlined,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '궁금해요',
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.smart_toy_outlined,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '공감하기',
            //                 )
            //               ],
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 15, vertical: 20),
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.message,
            //                   size: 20,
            //                 ),
            //                 SizedBox(width: 5),
            //                 Text(
            //                   '답변하기',
            //                 )
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(
            //         color: Colors.blueGrey[50],
            //         height: 10,
            //       ),
            //     ],
            //   ),
            // ),
            */
          ],
        ),
      ),
    );
  }

  Widget _categoryTypeButton(townPostCategoryType title) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey[400]!)),
        child: Text(controller.getCategoryType(title)),
      ),
    );
  }

  // 포스트 상단 카테고리 타입 영역
  Widget _postCategoryType_widget(String title) {
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

  Widget _contentArea_widget(String content, townPostCategoryType type) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      //본문 텍스트
      text: TextSpan(
        text: type == townPostCategoryType.question ? 'Q. ' : '',
        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: content,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal)),
          // TextSpan(
          //   text: '더보기',
          //   style: TextStyle(
          //     color: Colors.grey,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 10,
          //   ),
          //   recognizer: MultiTapGestureRecognizer()
          //     ..onTap = (a) {
          //       print('touch $a');
          //     },
          // ),
        ],
      ),
    );
  }

  // 이미지 목록
  Widget _imageList_widget(List? imgURL) {
    List<Widget> imgList = [];

    const double imageAreaHeight = 150;
    if (imgURL == null) {
      return Container();
    } else if (imgURL.length == 1) {
      imgList.add(
        Expanded(
          child: Container(
            child: Image.asset(
              imgURL[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (imgURL.length == 2) {
      imgList.addAll(
        [
          Container(
            height: imageAreaHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (imgURL.length == 3) {
      imgList.addAll(
        [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (imgURL.length == 4) {
      imgList.addAll(
        [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[3],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      imgList.addAll(
        [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      imgURL[2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        child: Image.asset(
                          imgURL[3],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.5),
                        alignment: Alignment.center,
                        child: Text(
                          '+ ${imgURL.length - 4}',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          height: imageAreaHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: imgList,
          )),
    );
  }

  Widget _locationInfo_widget(String? storeName, String? storeAddress) {
    if (storeName == null || storeAddress == null) return Container();
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1,
          // color: Colors.blueGrey,
          color: Colors.blueGrey[100]!,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  storeName,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  storeAddress,
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _postContent(TownPostInfo data) {
    return Container(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    //상단 카테고리 타입
                    children: [
                      _postCategoryType_widget(data.category),
                    ],
                  ),
                  SizedBox(height: 10),
                  _contentArea_widget(data.content, data.categoryType),
                  SizedBox(height: data.imageURL == null ? 0 : 10),
                  _imageList_widget(data.imageURL),
                  SizedBox(height: data.storeName == null ? 0 : 15),
                  _locationInfo_widget(data.storeName, data.storeAddress),
                  SizedBox(height: 30),
                  Row(
                    //게시글 작성 정보
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.writer} · ${data.town}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        data.postTimeFromNow,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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
            //하단 버튼 리스트
            children: [
              data.categoryType == townPostCategoryType.question
                  ? Container(
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
                    )
                  : Container(
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
          Container(
            color: Colors.blueGrey[50],
            height: 10,
          ),
        ],
      ),
    );
  }
}
