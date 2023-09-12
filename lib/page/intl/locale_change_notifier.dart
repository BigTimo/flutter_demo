import 'package:flutter/cupertino.dart';

///
///@author Free
///@date 2023/9/13
class LocaleChangeNotifier extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void init(Locale locale) {
    _locale = locale;
  }

  void change(Locale locale) {
    if (_locale.toString() != locale.toString()) {
      _locale = locale;
      notifyListeners();
    }
  }
}
