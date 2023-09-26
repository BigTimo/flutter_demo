import 'package:flutter/material.dart';

import 'small_window_widget.dart';

///
///@author Free
///@date 2023/9/26
class SmallWindowManager {
  static final SmallWindowManager _instance = SmallWindowManager._();

  factory SmallWindowManager() => _instance;

  SmallWindowManager._();

  ///浮窗
  OverlayEntry? overlayEntry;

  show(BuildContext context) {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return SmallWindowWidget(
          top: 160,
          left: 279,
          child: GestureDetector(
            onTap: () {
              hide();
            },
            child: Material(
              child: Container(
                color: Colors.red,
                width: 100,
                height: 200,
                child: const Center(
                  child: Text("small"),
                ),
              ),
            ),
          ),
        );
      });
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  ///关闭小窗
  void hide() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
