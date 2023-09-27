import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/page/getx/a_page.dart';
import 'package:flutter_demo/page/getx/b_page.dart';
import 'package:flutter_demo/page/getx/c_page.dart';
import 'package:get/get.dart';


///路由配置类
class RouteConfig {
  static const String home = "/home";
  static const String a = "/a";
  static const String b = "/b";
  static const String c = "/c";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => const MyHomePage()),
    GetPage(name: a, page: () => const APage()),
    GetPage(name: b, page: () => const BPage()),
    GetPage(name: c, page: () => const CPage()),
  ];
}
