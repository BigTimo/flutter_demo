import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'generated/assets.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late InAppWebViewController controller;

  String bridgeName = "NativeBridge";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebDemo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              onWebViewCreated: onWebViewCreated,
              initialUserScripts: UnmodifiableListView<UserScript>([
                UserScript(
                  source: getInjectJS(bridgeName, JsCallAppMethod.values.map((e) => e.name).toList()),
                  injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
                ),
              ]),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    appCallJs(method: AppCallJsMethod.jsAlert, params: {"text": "jsAlert"});
                  },
                  child: Text(AppCallJsMethod.jsAlert.name),
                ),
                ElevatedButton(
                  onPressed: () {
                    appCallJs(method: AppCallJsMethod.getJsInfo).then((value) => alert(value));
                  },
                  child: Text(AppCallJsMethod.getJsInfo.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void alert(dynamic param) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(param.toString()),
        );
      },
    );
  }

  ///flutter_inappwebview默认只有window.flutter_inappwebview.callHandler方法，不能自定义
  ///
  ///这里做一个中转注入，即可使用window.youName.youMethod(args)
  ///
  ///生成代码如下
  ///
  ///window.NativeBridge = {
  ///     getConfig: (...args) => window.flutter_inappwebview.callHandler("NativeBridge", 'getConfig', ...args),
  ///     destroy: (...args) => window.flutter_inappwebview.callHandler("NativeBridge", 'destroy', ...args),
  ///}
  ///
  String getInjectJS(String bridgeName, List<String> methodNames) {
    final js = StringBuffer();
    js.write("window.$bridgeName = {");
    for (var name in methodNames) {
      js.write('$name: (...args) => window.flutter_inappwebview.callHandler("$bridgeName", "$name", ...args),');
    }
    js.write("}");
    return js.toString();
  }

  void onWebViewCreated(InAppWebViewController controller) {
    InAppWebViewController.setWebContentsDebuggingEnabled(true);
    this.controller = controller;
    InAppWebViewController.setWebContentsDebuggingEnabled(true);
    controller.loadFile(assetFilePath: Assets.htmlH5);
    controller.addJavaScriptHandler(
      handlerName: bridgeName,
      callback: (List<dynamic> arguments) {
        //这里做了处理,返回的结果为[methodName,...args]
        if (arguments.isNotEmpty) {
          var method = arguments[0];
          Map<String, dynamic>? param;
          if (arguments.length > 1) {
            param = jsonDecode(arguments[1]);
          }
          if (method is String) {
            var parse = JsCallAppMethod.parse(method);
            if (parse == null) {
              //未实现对应方法
            } else {
              return jsCallApp(method: parse, params: param);
            }
          }
        }
      },
    );
  }

  jsCallApp({required JsCallAppMethod method, Map<String, dynamic>? params}) {
    switch (method) {
      case JsCallAppMethod.getAppInfo:
        return jsonEncode({
          "info": "AppInfo",
        });
      case JsCallAppMethod.appAlert:
        alert(params);
        break;
    }
  }

  Future<dynamic> appCallJs({required AppCallJsMethod method, Map<String, dynamic>? params}) {
    String json = jsonEncode(params);
    var js = "window.${method.name}('$json')";
    return controller.evaluateJavascript(source: js);
  }
}

enum JsCallAppMethod {
  getAppInfo,
  appAlert,
  ;

  static JsCallAppMethod? parse(String name) {
    try {
      return JsCallAppMethod.values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }
}

enum AppCallJsMethod {
  getJsInfo,
  jsAlert,
  ;
}
