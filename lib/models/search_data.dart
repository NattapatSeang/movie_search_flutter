import 'package:flutter/foundation.dart';

class SearchData extends ChangeNotifier {
  /// Get 5 search history
  List<String> _searchHistory = [];
  String _currentSearch = "";

  void addSearchHistory(String query) {
    if (_searchHistory.contains(query)) {
      _searchHistory.remove(query);
    } else {
      if (_searchHistory.length >= 5) {
        _searchHistory.removeAt(0);
      }
    }
    _searchHistory = _searchHistory.reversed.toList();
    _searchHistory.add(query);
    _searchHistory = _searchHistory.reversed.toList();

    notifyListeners();
  }

  String getSearchHistory(int index) {
    return _searchHistory[index];
  }

  String setCurrentSearch(String value) => _currentSearch = value;

  String get currentSearch => _currentSearch;

  int get historyCount => _searchHistory.length;
}
