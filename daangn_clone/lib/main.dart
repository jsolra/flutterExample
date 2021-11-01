import 'package:daangn/src/controller/app_controller.dart';
import 'package:daangn/src/controller/detail_controller.dart';
import 'package:daangn/src/controller/town_detail_controller.dart';
import 'package:daangn/src/controller/town_controller.dart';
import 'package:daangn/src/page/app.dart';
import 'package:daangn/src/page/detail.dart';
import 'package:daangn/src/page/favorite.dart';
import 'package:daangn/src/page/town_life.dart';
import 'package:daangn/src/page/town_life_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  // runApp(TestApp());
  runApp(MyApp());
  // runApp(MaterialApp(home: DemoApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
      // home: App(),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.put(AppController());
      }),
      getPages: [
        GetPage(name: '/', page: () => App()),
        GetPage(
            name: '/detail/:cid',
            page: () => DetailContentView(data: AppController.to.selectedData!),
            binding: BindingsBuilder(
                () => Get.lazyPut<DetailController>(() => DetailController()))),
        GetPage(
            name: '/townLifeDetail/:seq',
            page: () => TownLifeDetailPage(
                postData: Get.find<TownController>().detailData!),
            binding: BindingsBuilder(() =>
                Get.lazyPut<TownLifeDetailController>(
                    () => TownLifeDetailController()))),
        GetPage(name: '/favorite', page: () => Favoritepage()),
      ],
    );
  }
}

class TestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, primaryColor: Colors.white),
      home: TownLifePage(),
    );
  }
}
