import 'package:flutter/material.dart';
import 'package:flutter_demo/page/getx/route/get_extension.dart';
import 'package:flutter_demo/page/getx/route/route.dart';
import 'package:get/get.dart';

///
///@author Free
///@date 2023/9/27
class CPage extends StatelessWidget {
  const CPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPage'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.removeName(RouteConfig.a);
              },
              child: const Text("Remove A"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.removeName(RouteConfig.b);
              },
              child: const Text("Remove B"),
            ),
          ],
        ),
      ),
    );
  }
}
