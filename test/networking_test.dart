import 'dart:core';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/services/networking.dart';

import 'networking_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("Fetch data from network", () {
    test('Return query movie success', () async {
      String url = apiStartURL + "query=\"Mock Movie\"" + "&page=1";

      final client = MockClient();
      when(client.get(
        Uri.parse(url),
        headers: apiAuthHeader,
      )).thenAnswer((_) async => http.Response(
          '{"total_pages": 1,'
          '"total_results": 2,'
          '"results": ['
          '{"title":"Mock 1", "poster_path":"image.jpg", "release_date": "2019-12-12"},'
          '{"title":"Mock 2", "overview":"Mock overview", "vote_average": 4.2}'
          ']}',
          200));
      NetworkHelper helper = NetworkHelper();

      expect(
          await helper.getData(
              query: "Mock Movie", page: 1, mockClient: client),
          isA<Map>());
    });

    test('Return query movie fail', () async {
      String url = apiStartURL + "query=\"Mock Movie\"" + "&page=1";

      final client = MockClient();
      when(client.get(
        Uri.parse(url),
        headers: apiAuthHeader,
      )).thenAnswer((_) async => http.Response('Not Found', 404));
      NetworkHelper helper = NetworkHelper();

      expect(
          await helper.getData(
              query: "Mock Movie", page: 1, mockClient: client),
          null);
    });
  });
}
