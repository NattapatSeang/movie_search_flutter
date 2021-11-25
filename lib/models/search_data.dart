import 'package:flutter/foundation.dart';

/// ------------------------------------------------------------
/// Model for search data provider
/// ------------------------------------------------------------
class SearchData extends ChangeNotifier {
  /// List of search history
  List<String> _searchHistory = [];

  /// Current search string
  String _currentSearch = "";

  /// Add more search history
  void addSearchHistory(String query) {
    // Max only five. if exceed, delete the last in search history
    if (_searchHistory.contains(query)) {
      _searchHistory.remove(query);
    } else {
      if (_searchHistory.length >= 5) {
        _searchHistory.removeAt(_searchHistory.length - 1);
      }
    }

    // to make the recent search on the top
    _searchHistory = _searchHistory.reversed.toList();
    _searchHistory.add(query);
    _searchHistory = _searchHistory.reversed.toList();

    notifyListeners();
  }

  /// Get search history
  /// - index = index of that search history
  String getSearchHistory(int index) {
    return _searchHistory[index];
  }

  /// Set data for current search
  /// - value = what is currently search
  String setCurrentSearch(String value) => _currentSearch = value;

  /// Get what is currently searching
  String get currentSearch => _currentSearch;

  /// Get the number of how many entry are in search history
  int get historyCount => _searchHistory.length;
}
