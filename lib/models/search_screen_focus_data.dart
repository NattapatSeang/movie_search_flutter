import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class SearchScreenFocusData extends ChangeNotifier {
  bool _cancelBtnVisibility = false;

  void textFieldFocus(bool isVisible, BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    _cancelBtnVisibility = isVisible;
    notifyListeners();

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    print(_cancelBtnVisibility);
  }

  bool getCancelVisibility() {
    print("hehe: $_cancelBtnVisibility");
    return _cancelBtnVisibility;
  }
}
