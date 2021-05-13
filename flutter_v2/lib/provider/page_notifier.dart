import 'package:flutter/cupertino.dart';
import 'package:flutter_v2/pages/auth_page.dart';
import 'package:flutter_v2/pages/my_home.dart';

class PageNotifier extends ChangeNotifier {
  String _currentPage = AuthPage.pageName;

  String get currentPage => _currentPage;

  void goToMain() {
    _currentPage = MyHomePage.pageName;
    notifyListeners();
  }

  void goToOtherPage(String name) {
    _currentPage = name;
    notifyListeners();
  }
}
