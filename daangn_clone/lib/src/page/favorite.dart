import 'package:daangn/src/controller/app_controller.dart';
import 'package:daangn/src/page/detail.dart';
import 'package:daangn/src/repository/contents_repository.dart';
import 'package:daangn/src/util/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyFavoriteContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appbarWidget() {
    return AppBar(
      title: Text(
        '관심목록',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
        future: AppController.to.loadContentsFromFavorite(),
        builder: (BuildContext context, dynamic snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print('error');
            return Center(
              child: Text('데이터 오류'),
            );
          }

          if (snapshot.hasData) {
            print('call ');
            print(snapshot.data.toString());
            return _makeDataList();
          } else {
            print('no data');
            return Center(
              child: Text('즐겨찾기 한 상품이 없습니다'),
            );
          }
        });
  }

  Widget _makeDataList() {
    return Obx(
      () => AppController.to.favoriteContentList.length == 0
          ? Center(
              child: Text('즐겨찾기 한 상품이 없습니다'),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: AppController.to.favoriteContentList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.5),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    print(index);
                    AppController.to.selectedData =
                        AppController.to.favoriteContentList[index];

                    Get.toNamed(
                        '/detail/${AppController.to.favoriteContentList[index]['cid']}');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return DetailContentView(data: datas[index]);
                    // }));
                    // print(datas[index]['title']);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          child: Hero(
                            tag: AppController.to.favoriteContentList[index]
                                ['cid']!,
                            child: Image.asset(
                              AppController.to.favoriteContentList[index]
                                  ['image']!,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    AppController.to.favoriteContentList[index]
                                        ['title']!,
                                    style: TextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    AppController.to.favoriteContentList[index]
                                        ['location']!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black.withOpacity(0.3)),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    DataUtils.to.calcStringToWon(AppController
                                        .to
                                        .favoriteContentList[index]['price']!),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/heart_off.svg',
                                          width: 13,
                                          height: 13,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(AppController
                                                .to.favoriteContentList[index]
                                            ['likes']!),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
