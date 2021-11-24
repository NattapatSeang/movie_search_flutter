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
    notifyListeners();
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

  Future<bool> updateFavorite() async {
    try {
      for (var favMovie in _favoriteMovies) {
        List<Movie>? temp = await getQueryList(favMovie.movieName, null);
        if (temp != null) {
          Movie? updatedFavMovie = temp.firstWhereOrNull(
            (element) => element.movieName == favMovie.movieName,
          );
          if (updatedFavMovie != null) {
            removeFavorite(favMovie);
            addFavorite(favMovie);
          }
        }
      }
    } catch (e) {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  /// List of query result -> return true if query is success.
  List<Movie> _queryResult = [];
  bool get isResultEmpty => _queryResult.isEmpty;

  /// Query from search string
  bool _stillQuery = false;
  bool get queryStage => _stillQuery;
  void toggleQueryState() => _stillQuery = !_stillQuery;

  bool _hasError = false;
  bool get hasError => _hasError;

  Future<List<Movie>?> getQueryList(String queryString, int? page) async {
    try {
      Map? apiReturn = await helper.getData(query: queryString, page: page);

      var result = apiReturn!["results"] as List;

      return result.map((data) => Movie.fromJson(data)).toList();
    } catch (e) {
      _hasError = true;
      notifyListeners();
    }
    return null;
  }

  Future<bool> queryMovie(String queryString, int? page) async {
    if (page == 1) {
      _queryResult = [];
      _hasError = false;
    }
    if (!_hasError) {
      List<Movie>? temp = await getQueryList(queryString, page);

      if (temp != null) {
        if (page == 1) {
          _queryResult = temp;
        } else {
          _queryResult.addAll(temp);
        }
        if (temp.isNotEmpty) {
          notifyListeners();
          return true;
        }
      }
    }
    notifyListeners();
    return false;
  }

  /// Get data from provider
  Movie getMovie({required int index, required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies[index] : _queryResult[index];

  int movieCount({required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies.length : _queryResult.length;
}
