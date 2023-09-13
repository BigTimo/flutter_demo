import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_demo/main.dart';

class AssetsUtil {
  static Future<List<String>> getAssetsList() async {
    final assetBundle = rootBundle;
    final manifestContent = await assetBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    return manifestMap.keys.where((String key) => key.startsWith('assets/')).toList();
  }
}

extension AssetsIntlExtension on String {
  ///判断如果某张图片有对应的国际化图片，使用国际化图片，否则使用原图
  String get intl {
    String path = replaceAll("assets/img", "assets/img_${localeChangeNotifier.locale!.toString().toLowerCase()}");
    if (assetPaths.contains(path)) {
      return path;
    } else {
      return this;
    }
  }
}
