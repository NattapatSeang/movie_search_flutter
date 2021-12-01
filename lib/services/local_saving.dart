import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:movie_search/models/movie.dart';
import 'package:path_provider/path_provider.dart';

/// ------------------------------------------------------------
/// Class that's used for help save data locally
/// ------------------------------------------------------------
class LocalSaveHelper {
  final String toFileName;
  final String? customPath;

  LocalSaveHelper({required this.toFileName, this.customPath});

  /// Get path to save locally in mobile phone
  Future<String> get localPath async {
    final Directory directory;
    if (customPath != null) {
      return customPath!;
    }
    directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Get file location to save in
  Future<File> get _localFile async {
    final path = await localPath;
    return File('$path/$toFileName');
  }

  /// Read object from file
  Future<List> readObjectList() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return jsonDecode(contents);
    } catch (e) {
      // If encountering an error, return empty
      return [];
    }
  }

  /// Write object to file
  /// - objectList = list of object to write
  Future<File> writeObjectList(List<Movie> objectList) async {
    final file = await _localFile;

    String jsonString = jsonEncode(objectList);
    // Write the file
    return file.writeAsString(jsonString);
  }
}
