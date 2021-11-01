import 'package:daangn/src/component/post_widget.dart';
import 'package:daangn/src/controller/town_detail_controller.dart';
import 'package:daangn/src/model/town_post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TownLifeDetailPage extends GetView<TownLifeDetailController> {
  final TownPostInfo postData;
  TownLifeDetailPage({Key? key, required this.postData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initData();
    return Scaffold(
      appBar: AppBar(),
      body: _bodyWidget(),
    );
  }

  late TownDetailInfo data;
  void initData() {
    List<TownCommentInfo> comm = [];
    comm.add(TownCommentInfo(
        seq: 1,
        id: '댓글러',
        town: '군자동',
        content:
            '모니터 케이블을 그래픽 카드 단자에 제대로 연결 하셨는지? 카드 장착후 메인보드에 연결하시는 분 간혹 있는데 그러면 안됩니다',
        postTime: DateTime(2021, 11, 01, 17, 53, 55)));
    comm.add(TownCommentInfo(
        seq: 2,
        id: 'ghgihihi',
        town: '면목동',
        profileURL: 'assets/images/ara-5.jpg',
        content: '이런경우 케이블 문제입니다\n 다른 케이블로 연결해보셨나요?',
        postTime: DateTime(2021, 11, 01, 17, 43, 55)));

    data = TownDetailInfo(data: postData, commentList: comm);
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  postCategoryType_widget(data.data.category),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              Image.asset('assets/images/user2.png').image,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '사용자아이디',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '화양동 인증 2회 · 3시간 전',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    color: Colors.blueGrey[100]!,
                  ),
                  Text(
                      '안녕하세요 전역하고 컴퓨터 바꾸려니 어쩌구저쩌구 컴퓨터를 그냥 쓰려고 했습니다. 그런데 컴퓨터 본체에 전원은 들어오는데 모니터는 안나오네요. 제가 컴알못이라 여기저기 주워들은걸로 그래픽카드 문제인가 다른 모니터에 연결을 해봤는데 마찬가지로 안들어오더라구요. 컴퓨터 수리를 맡기려고 하는데, 자양3동 근처에 괜찮은 업체 있을까요 추천부탁드려요'),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.privacy_tip,
                        color: Colors.grey,
                        size: 15,
                      ),
                      Text(
                        ' 부적절한 게시글이라면 당근마켓에 알려주세요',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  postBottomButton_widget(data.data),
                  _commentList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sortButton(bool type) {
    String title = type ? '최신순' : '등록순';

    return InkWell(
      onTap: () {
        controller.setSort(type);
      },
      child: Container(
        child: Obx(
          () => controller.SortNewest.value == type
              ? Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 3,
                    ),
                    SizedBox(width: 5),
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _commentList() {
    if (data.data.commentCount == 0) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Icon(
              Icons.sms,
              size: 50,
              color: Colors.grey,
            ),
            SizedBox(height: 10),
            Text(
              '아직 댓글이 없어요.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.grey),
            ),
            Text(
              '가장 먼저 댓글을 남겨보세요.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return Obx(() => Container(
          child: Column(
            children: [
              Row(
                children: [
                  _sortButton(false),
                  SizedBox(width: 25),
                  _sortButton(true),
                ],
              ),
              for (int i = 0; i < data.commentList!.length; i++)
                controller.SortNewest.value
                    ? _comment_widget(List.from(data.commentList!.reversed)[i])
                    : _comment_widget(data.commentList![i]),
            ],
          ),
        ));
  }

  Widget _comment_widget(TownCommentInfo data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: Image.asset(data.profileURL == null
                    ? 'assets/images/user2.png'
                    : data.profileURL!)
                .image,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.id,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${data.town} · ${data.postTimeFromNow}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(data.content),
                SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        print('like');
                      },
                      child: Text(
                        '좋아요',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        print('reply');
                      },
                      child: Text(
                        '답글쓰기',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
              onTap: () {
                print('more button');
              },
              child: Icon(
                Icons.more_vert,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
