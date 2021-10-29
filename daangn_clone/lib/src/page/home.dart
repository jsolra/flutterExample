import 'package:daangn/src/component/appbar_widget.dart';
import 'package:daangn/src/controller/app_controller.dart';
import 'package:daangn/src/util/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  List<Map<String, String>> datas = [];

  final Map<String, String> locationTypeToString = {
    "ara": '아라동',
    "ora": '오라동',
    "donam": '도남동',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: _bodyWidget(),
    );
  }

  AppBar _appbarWidget() {
    return AppBar(
      elevation: 1,
      title: GestureDetector(
        child: PopupMenuButton<String>(
          onSelected: (String where) {
            AppController.to.currentLocation(where);
          },
          offset: Offset(0, 30),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "ara", child: Text("아라동")),
              PopupMenuItem(value: "ora", child: Text("오라동")),
              PopupMenuItem(value: "donam", child: Text("도남동")),
            ];
          },
          child: Row(
            children: [
              Obx(() => Text(
                  locationTypeToString[AppController.to.currentLocation]!)),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
        onTap: () {
          print('click');
        },
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svg/bell.svg',
              width: 22,
            )),
      ],
    );
  }

  Future<List<Map<String, String>>> _loadContents() async {
    List<Map<String, String>> responseData = await AppController.to
        .loadContentsFromLocation(AppController.to.currentLocation.value);
    return responseData;
  }

  Widget _bodyWidget() {
    return Obx(
      () => FutureBuilder(
        future: AppController.to
            .loadContentsFromLocation(AppController.to.currentLocation.value),
        // future: _loadContents(),
        builder: (BuildContext context, dynamic snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('데이터 오류'),
            );
          }

          if (snapshot.hasData) {
            return _makeDataList(snapshot.data);
          } else
            return Center(
              child: Text('해당 지역의 데이터가 없습니다'),
            );
        },
      ),
    );
  }

  Widget _makeDataList(List<dynamic> datas) {
    int size = datas == null ? 0 : datas.length;

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: size,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.5),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            AppController.to.selectedData = datas[index];
            Get.toNamed('/detail/${datas[index]['cid']}');

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
                    tag: datas[index]['cid']!,
                    child: Image.asset(
                      datas[index]['image']!,
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
                            datas[index]['title']!,
                            style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text(
                            datas[index]['location']!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.3)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            DataUtils.to
                                .calcStringToWon(datas[index]['price']!),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/heart_off.svg',
                                  width: 13,
                                  height: 13,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(datas[index]['likes']!),
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
    );
  }
}
