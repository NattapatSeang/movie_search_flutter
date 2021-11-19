import 'package:flutter/foundation.dart';

class SearchData extends ChangeNotifier {
  /// Get 5 search history
  List<String> _searchHistory = [];
  String _currentSearch = "";

  void addSearchHistory(String query) {
    if (_searchHistory.length >= 5) {
      _searchHistory.removeAt(0);
    }
    _searchHistory.add(query);
    _currentSearch = query;
    notifyListeners();
  }

  String getSearchHistory(int index) {
    return _searchHistory[index];
  }

  String get currentSearch => _currentSearch;

  int get historyCount => _searchHistory.length;
}
