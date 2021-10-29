import 'package:daangn/src/page/favorite.dart';
import 'package:daangn/src/page/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }

  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedFontSize: 12,
        onTap: (int index) {
          print(index);
          setState(() {
            _currentPageIndex = index;
          });
        },
        currentIndex: _currentPageIndex,
        items: [
          _bottomNavigationBarItem('home', '홈'),
          _bottomNavigationBarItem('notes', '동네생활'),
          _bottomNavigationBarItem('location', '내근처'),
          _bottomNavigationBarItem('chat', '채팅'),
          _bottomNavigationBarItem('user', '나의 당근'),
        ]);
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String iconName, String label) {
    return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset('assets/svg/${iconName}_off.svg', width: 22),
        ),
        activeIcon: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: SvgPicture.asset('assets/svg/${iconName}_on.svg', width: 22),
        ),
        label: label);
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
      case 1:
        return Container();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return MyFavoriteContents();
      default:
        return Container();
    }
  }
}
