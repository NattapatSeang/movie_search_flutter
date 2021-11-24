import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/constants.dart';

class NetworkHelper {
  Future<Map?> getData({required String query, int? page}) async {
    String url = "";
    if (page != null) {
      url = kStartUrl + "query=\"$query\"" + "&page=$page";
    } else {
      url = url = kStartUrl + "query=\"$query\"";
    }

    http.Response response = await http.get(
      Uri.parse(url),
      headers: kAuthHeader,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
