import 'package:daangn/src/page/detail.dart';
import 'package:daangn/src/repository/contents_repository.dart';
import 'package:daangn/src/util/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyFavoriteContents extends StatefulWidget {
  MyFavoriteContents({Key? key}) : super(key: key);

  @override
  _MyFavoriteContentsState createState() => _MyFavoriteContentsState();
}

class _MyFavoriteContentsState extends State<MyFavoriteContents> {
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }

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
        future: _loadMyFavoriteContentList(),
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
        });
  }

  Future<dynamic> _loadMyFavoriteContentList() async {
    return await contentsRepository.loadFavoriteContents();
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
            print(index);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailContentView(data: datas[index]);
            }));
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
