import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/services/local_saving.dart';
import 'package:movie_search/services/networking.dart';

class MovieData extends ChangeNotifier {
  /// Network helper: for query purpose
  NetworkHelper helper = NetworkHelper();

  /// List of favorite movies
  List<Movie> _favoriteMovies = [];

  bool inFavorite(Movie movie) => (_favoriteMovies.firstWhereOrNull(
        (element) => element.movieName == movie.movieName,
      ) !=
      null);

  void initLoadFavorites() async {
    List result = await LocalSaveHelper.readObjectList();
    _favoriteMovies = result.map((data) => Movie.fromJson(data)).toList();
    //print(_favoriteMovies.last.movieName);
  }

  void addFavorite(Movie newFavorite) async {
    _favoriteMovies.add(newFavorite);
    await LocalSaveHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  void removeFavorite(Movie removeMovie) async {
    _favoriteMovies
        .removeWhere((element) => element.movieName == removeMovie.movieName);
    await LocalSaveHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  /// List of query result -> return true if query is success.
  List<Movie> _queryResult = [];

  /// Query from search string
  bool _stillQuery = false;
  bool get queryStage => _stillQuery;
  void toggleQueryState() => _stillQuery = !_stillQuery;

  Future<bool> queryMovie(String queryString, int page) async {
    Map apiReturn = await helper.getData(query: queryString, page: page);

    if (apiReturn != null) {
      var result = apiReturn["results"] as List;

      /// will change later
      if (result.length != 0) {
        if (page == 1) {
          _queryResult = result.map((data) => Movie.fromJson(data)).toList();
        } else {
          //print("he: ${result[0]['poster_path']}");
          var temp = result.map((data) => Movie.fromJson(data)).toList();
          _queryResult.addAll(temp);
        }
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
    //_queryResult = result;
  }

  /// Get data from provider
  Movie getMovie({required int index, required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies[index] : _queryResult[index];

  int movieCount({required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies.length : _queryResult.length;
}
