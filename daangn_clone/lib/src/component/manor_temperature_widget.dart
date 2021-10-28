import 'package:flutter/material.dart';

class ManorTemperature extends StatelessWidget {
  double manorTemp;
  late int level;
  final List<Color> temperColor = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];
  ManorTemperature({Key? key, required this.manorTemp}) {
    _calcTempLevel();
  }
  void _calcTempLevel() {
    if (manorTemp <= 20) {
      level = 0;
    } else if (manorTemp <= 32) {
      level = 1;
    } else if (manorTemp <= 36.5) {
      level = 2;
    } else if (manorTemp <= 40) {
      level = 3;
    } else if (manorTemp <= 50) {
      level = 4;
    } else {
      level = 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              _makeTempLabelAndBar(),
              Text(
                '매너온도',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.underline),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 7),
            width: 30,
            height: 30,
            child: Image.asset('assets/images/level-${level}.jpg'),
          ),
        ],
      ),
    );
  }

  Widget _makeTempLabelAndBar() {
    return Container(
      width: 60,
      child: Column(
        children: [
          Text(
            "$manorTemp°C",
            style: TextStyle(
                color: temperColor[level],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 6,
              color: Colors.black.withOpacity(0.2),
              child: Row(
                children: [
                  Expanded(
                    flex: manorTemp.round(),
                    child: Container(
                      height: 6,
                      color: temperColor[level],
                    ),
                  ),
                  Expanded(
                    flex: 100 - manorTemp.round(),
                    child: Container(
                      height: 6,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
