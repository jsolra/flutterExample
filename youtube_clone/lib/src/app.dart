import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:youtube_clone/src/controller/app_controller.dart';
import 'package:youtube_clone/src/pages/Library_page.dart';
import 'package:youtube_clone/src/pages/explore_page.dart';
import 'package:youtube_clone/src/pages/home_page.dart';
import 'package:youtube_clone/src/pages/subscribe_page.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          switch (RouteName.values[controller.currentIndex.value]) {
            case RouteName.Home:
              return Home();
            case RouteName.Explore:
              return Explore();
            case RouteName.Add:
              //bottomsheet
              break;
            case RouteName.Subscribe:
              return Subscribe();
            case RouteName.Library:
              return Library();
          }
          return Container();
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            showSelectedLabels: true,
            selectedItemColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePageIndex,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/home_off.svg',
                    width: 22,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icons/home_on.svg',
                    width: 22,
                  ),
                  label: '홈'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/compass_off.svg',
                    width: 22,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icons/compass_on.svg',
                    width: 22,
                  ),
                  label: '탐색'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SvgPicture.asset(
                      'assets/svg/icons/plus.svg',
                      width: 35,
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/subs_off.svg',
                    width: 22,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icons/subs_on.svg',
                    width: 22,
                  ),
                  label: '구독'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/icons/library_off.svg',
                    width: 22,
                  ),
                  activeIcon: SvgPicture.asset(
                    'assets/svg/icons/library_on.svg',
                    width: 22,
                  ),
                  label: '보관함'),
            ],
          ),
        ));
  }
}
