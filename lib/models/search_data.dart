import 'package:flutter/foundation.dart';
import 'package:movie_search/constants.dart';

/// ------------------------------------------------------------
/// Model for search data provider
/// ------------------------------------------------------------
class SearchData extends ChangeNotifier {
  List<String> _searchHistory = [];

  String _currentSearch = "";

  void addSearchHistory(String query) {
    // Max only five. if exceed, delete the last in search history
    if (_searchHistory.contains(query)) {
      _searchHistory.remove(query);
    } else {
      if (_searchHistory.length >= maxSearchHistory) {
        _searchHistory.removeAt(_searchHistory.length - 1);
      }
    }

    // to make the recent search on the top
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
