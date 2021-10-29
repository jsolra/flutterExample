import 'package:daangn/src/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

//
class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  final Map<String, String> locationTypeToString = {
    "ara": '아라동',
    "ora": '오라동',
    "donam": '도남동',
  };

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
}
