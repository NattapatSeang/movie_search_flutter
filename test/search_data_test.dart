import 'package:flutter_test/flutter_test.dart';
import 'package:movie_search/models/search_data.dart';

void main() {
  group("Search Data", () {
    test('Able to add search data as stack', () async {
      SearchData searchData = SearchData();

      searchData.addSearchHistory("Mock Query1");
      searchData.addSearchHistory("Mock Query2");

      expect(searchData.historyCount, 2);
      expect(searchData.getSearchHistory(0), "Mock Query2");
      expect(searchData.getSearchHistory(1), "Mock Query1");
    });

    test('Able to limit the adding to 5', () async {
      SearchData searchData = SearchData();

      searchData.addSearchHistory("Mock Query1");
      searchData.addSearchHistory("Mock Query2");
      searchData.addSearchHistory("Mock Query3");
      searchData.addSearchHistory("Mock Query4");
      searchData.addSearchHistory("Mock Query5");
      searchData.addSearchHistory("Mock Query6");

      expect(searchData.historyCount, 5);
      expect(searchData.getSearchHistory(0), "Mock Query6");
      expect(searchData.getSearchHistory(1), "Mock Query5");
      expect(searchData.getSearchHistory(2), "Mock Query4");
      expect(searchData.getSearchHistory(3), "Mock Query3");
      expect(searchData.getSearchHistory(4), "Mock Query2");
    });

    test('Able to move up repeated search to the first', () async {
      SearchData searchData = SearchData();

      searchData.addSearchHistory("Mock Query1");
      searchData.addSearchHistory("Mock Query2");
      searchData.addSearchHistory("Mock Query3");
      searchData.addSearchHistory("Mock Query4");
      searchData.addSearchHistory("Mock Query5");
      searchData.addSearchHistory("Mock Query6");
      searchData.addSearchHistory("Mock Query3");

      expect(searchData.historyCount, 5);
      expect(searchData.getSearchHistory(0), "Mock Query3");
      expect(searchData.getSearchHistory(1), "Mock Query6");
      expect(searchData.getSearchHistory(2), "Mock Query5");
      expect(searchData.getSearchHistory(3), "Mock Query4");
      expect(searchData.getSearchHistory(4), "Mock Query2");
    });
  });
}
