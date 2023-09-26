import 'package:flutter/material.dart';
import 'package:flutter_demo/page/small_window/small_window_manager.dart';

///
///@author Free
///@date 2023/9/26
class SmallWindowPage extends StatefulWidget {
  const SmallWindowPage({super.key});

  @override
  State<SmallWindowPage> createState() => _SmallWindowPageState();
}

class _SmallWindowPageState extends State<SmallWindowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmallWindow'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                SmallWindowManager().show(context);
              },
              child: Text("show")),
          ElevatedButton(
              onPressed: () {
                SmallWindowManager().hide();
              },
              child: Text("hide")),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(SmallWindowPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
