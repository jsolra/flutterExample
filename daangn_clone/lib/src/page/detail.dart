import 'package:carousel_slider/carousel_slider.dart';
import 'package:daangn/src/component/manor_temperature_widget.dart';
import 'package:daangn/src/controller/detail_controller.dart';
import 'package:daangn/src/util/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DetailContentView extends StatefulWidget {
  Map<String, dynamic> data;
  DetailContentView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView>
    with SingleTickerProviderStateMixin {
  DetailController controller = Get.find();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Size size;
  List<String> imgList = [];
  int _current = 0;

  ScrollController _scrollController = ScrollController();
  double scrollpositionToAlpha = 0;
  CarouselController _controller = CarouselController();

  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMyFavoriteContentState();

    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);

    _scrollController.addListener(() {
      setState(() {
        scrollpositionToAlpha = _scrollController.offset;

        if (scrollpositionToAlpha >= 255) scrollpositionToAlpha = 255;

        _animationController.value = scrollpositionToAlpha / 255;
      });
    });
  }

  void _loadMyFavoriteContentState() async {
    bool ck = await controller.isMyFavoriteContents(widget.data["cid"]!);
    print(ck);
    controller.isMyFavoriteContent(ck);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;

    imgList.add(widget.data['image']!);
    imgList.add(widget.data['image']!);
    imgList.add(widget.data['image']!);
    imgList.add(widget.data['image']!);
    imgList.add(widget.data['image']!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }

  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Icon(icon, color: _colorTween.value),
    );
  }

  AppBar _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()),
      elevation: 0,
      leading: IconButton(
        icon: _makeIcon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.share)),
        IconButton(onPressed: () {}, icon: _makeIcon(Icons.more_vert)),
      ],
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 55,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (controller.isMyFavoriteContent.value) {
                //제거
                controller.deleteFavoriteContent(widget.data['cid']!);
              } else {
                //추가
                controller.addMyFavoriteContent(widget.data);
              }

              scaffoldKey.currentState!.showSnackBar(SnackBar(
                content: Text(controller.isMyFavoriteContent.value
                    ? "관심 목록에 추가되었습니다"
                    : "관심 목록에서 제거되었습니다"),
                duration: Duration(milliseconds: 1000),
              ));
            },
            child: Obx(
              () => SvgPicture.asset(
                controller.isMyFavoriteContent.value
                    ? 'assets/svg/heart_on.svg'
                    : 'assets/svg/heart_off.svg',
                width: 25,
                height: 25,
                color: Color(0xfff08f4f),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            width: 1,
            height: 40,
            color: Colors.black.withOpacity(0.1),
          ),
          Column(
            children: <Widget>[
              Text(
                DataUtils.to.calcStringToWon(widget.data['price']!),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                '가격 제안 불가',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
              color: Color(0xfff08f4f),
              child: Text(
                '채팅으로 거래하기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeSliderImage() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data['cid']!,
            child: CarouselSlider(
                items: imgList
                    .map(
                      (url) => Image.asset(
                        url,
                        width: size.width,
                        fit: BoxFit.fill,
                      ),
                    )
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                    height: size.width,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      print(index);
                      setState(() {
                        _current = index;
                      });
                    })),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     child: Image.asset('assets/images/user.png'),
          //   ),
          // ),
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset('assets/images/user.png').image,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '판매자',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '서울시 성동구',
                ),
              ],
            ),
          ),
          ManorTemperature(manorTemp: 37.5)
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                children: [
                  _makeSliderImage(),
                  _sellerSimpleInfo(),
                  _line(),
                  _contentDetail(),
                  _sellerInfo(),
                  _otherCellContents(),
                ],
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            delegate: SliverChildListDelegate(List.generate(
                20,
                (index) => Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.grey,
                              height: 120,
                            ),
                          ),
                          Text('goods title', style: TextStyle(fontSize: 14)),
                          Text('price',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ))),
          ),
        ),
      ],
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '판매자님의 판매 상품',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            '모두보기',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _sellerInfo() {
    return Column(
      children: [
        _line(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          alignment: Alignment.centerLeft,
          child: Text(
            '판매자정보',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        _line(),
      ],
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.data['title']!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            '디지털/가전 · 22시간 전',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '선물받은 새상품이고, 상품은 꺼내보기만 했어요.\n거래는 직거래만 합니다.\n\n찔러보기 사절\n제발 사주세요 빨리',
            style: TextStyle(
              height: 1.5,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '채팅 35 · 관심 1,095 · 조회 15,354',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.green.withOpacity(0.3),
    );
  }
}
