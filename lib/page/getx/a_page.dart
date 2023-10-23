import 'package:flutter/material.dart';
import 'package:flutter_demo/page/getx/route/get_extension.dart';
import 'package:flutter_demo/page/getx/route/route.dart';
import 'package:get/get.dart';

///
///@author Free
///@date 2023/9/27
class APage extends StatelessWidget {
  const APage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APage'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteConfig.b);
              },
              child: const Text("To B"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.removeName(RouteConfig.a);
              },
              child: const Text("Remove A"),
            ),
          ],
        ),
      ),
    );
  }
}
