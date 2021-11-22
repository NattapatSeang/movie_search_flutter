import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:movie_search/models/movie.dart';
import 'package:path_provider/path_provider.dart';

class LocalSaveHelper {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favorite.txt');
  }

  static Future<List> readObjectList() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      // print(contents);

      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return 0
      return [];
    }
  }

  static Future<File> writeObjectList(List<Movie> objectList) async {
    final file = await _localFile;

    String jsonString = jsonEncode(objectList);
    // Write the file
    return file.writeAsString(jsonString);
  }
}
