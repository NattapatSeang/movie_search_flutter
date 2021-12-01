import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/constants.dart';

/// ------------------------------------------------------------
/// Class that's used for help get data from api
/// ------------------------------------------------------------
class NetworkHelper {
  /// Get data from api
  /// - query = query what
  /// - page = query what page
  Future<Map?> getData(
      {required String query, int? page, http.Client? mockClient}) async {
    String url = "";
    if (page != null) {
      url = kStartUrl + "query=\"$query\"" + "&page=$page";
    } else {
      url = url = kStartUrl + "query=\"$query\"";
    }

    final http.Response response;

    try {
      if (mockClient == null) {
        response = await http.get(
          Uri.parse(url),
          headers: kAuthHeader,
        );
      } else {
        response = await mockClient.get(
          Uri.parse(url),
          headers: kAuthHeader,
        );
      }
    } catch (e) {
      return null;
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
