import 'package:flutter/material.dart';
import 'package:flutter_demo/page/getx/route/history_route_ovserver.dart';
import 'package:flutter_demo/page/getx/route/route.dart';
import 'package:flutter_demo/page/intl/assets_util.dart';
import 'package:flutter_demo/page/intl/locale_change_notifier.dart';
import 'package:flutter_demo/page/small_window/small_window_page.dart';
import 'package:flutter_demo/page/web/web_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';
import 'page/intl/intl_page.dart';

List<String> assetPaths = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  assetPaths = await AssetsUtil.getAssetsList();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

LocaleChangeNotifier localeChangeNotifier = LocaleChangeNotifier();

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: RouteConfig.home,
      getPages: RouteConfig.getPages,
      navigatorObservers: [routeHistoryObserver],
      locale: localeChangeNotifier.locale,
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        if (localeChangeNotifier.locale == null) {
          localeChangeNotifier.init(supportedLocales.contains(locale!) ? locale : const Locale("en"));
        }
        return localeChangeNotifier.locale;
      },
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
    );
  }

  @override
  void initState() {
    localeChangeNotifier.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    localeChangeNotifier.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(S.current.hello),
            Text(S.of(context).click_times(_counter)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WebPage()),
                );
              },
              child: const Text("web"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IntlPage()),
                );
              },
              child: const Text("Intl"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SmallWindowPage()),
                );
              },
              child: const Text("SmallWindow"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(RouteConfig.a);
              },
              child: const Text("Remove Page"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
