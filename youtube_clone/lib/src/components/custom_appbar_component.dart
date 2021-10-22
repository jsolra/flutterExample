import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _logo(),
        _actions(),
      ],
    );
  }

  Widget _logo() {
    return Container(
      child: Image.asset(
        'assets/images/logo.png',
        height: 50,
      ),
    );
  }

  Widget _actions() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 23,
            height: 23,
            child: SvgPicture.asset('assets/svg/icons/bell.svg'),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Get.toNamed('/search');
          },
          child: Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset('assets/svg/icons/search.svg'),
          ),
        ),
        SizedBox(width: 10),
        CircleAvatar(
          backgroundColor: Colors.grey.withOpacity(0.5),
          backgroundImage: Image.network(
                  'https://yt3.ggpht.com/ytc/AKedOLQagIEl2WOUacXZ8WlCPvApoIouP9sNGkMIDVdQ=s48-c-k-c0x00ffffff-no-rj')
              .image,
        )
      ],
    );
  }
}
