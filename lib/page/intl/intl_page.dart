import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/page/intl/assets_util.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class IntlPage extends StatefulWidget {
  const IntlPage({super.key});

  @override
  State<IntlPage> createState() => _IntlPageState();
}

class _IntlPageState extends State<IntlPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IntlPage')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imgFlag.intl,
              height: 100,
            ),
            Text(S.current.hello),
            Text(S.of(context).click_times(_counter)),
            Column(
              children: S.delegate.supportedLocales
                  .map((locale) => Row(
                        children: [
                          Radio(
                            value: locale.toString(),
                            onChanged: (value) {
                              localeChangeNotifier.change(locale);
                            },
                            groupValue: localeChangeNotifier.locale.toString(),
                          ),
                          Text(locale.toString()),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
