import 'package:flutter/material.dart';
import 'package:flutter_demo/page/getx/route/get_extension.dart';
import 'package:get/get.dart';

import 'route/route.dart';

///
///@author Free
///@date 2023/9/27
class BPage extends StatelessWidget {
  const BPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BPage'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteConfig.c);
              },
              child: const Text("To C"),
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
