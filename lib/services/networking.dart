import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/constants.dart';

/// ------------------------------------------------------------
/// Class that's used for help get data from api
/// ------------------------------------------------------------
class NetworkHelper {
  Future<Map?> getData(
      {required String query, int? page, http.Client? mockClient}) async {
    String url = "";

    url = "${apiStartURL}query=\"$query\"";

    if (page != null) {
      url = "$url&page=$page";
    }

    final http.Response response;

    try {
      if (mockClient == null) {
        response = await http.get(
          Uri.parse(url),
          headers: apiAuthHeader,
        );
      } else {
        response = await mockClient.get(
          Uri.parse(url),
          headers: apiAuthHeader,
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
