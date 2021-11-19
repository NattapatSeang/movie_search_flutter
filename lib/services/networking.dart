import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/constants.dart';

class NetworkHelper {
  Future<Map> getData({required String query, required int page}) async {
    String url = kStartUrl + "query=\"$query\"" + "&page=$page";

    http.Response response = await http.get(
      Uri.parse(url),
      headers: kAuthHeader,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return {'result': response.statusCode};
  }
}
