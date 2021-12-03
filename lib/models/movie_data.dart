import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/services/local_saving.dart';
import 'package:movie_search/services/networking.dart';

/// ------------------------------------------------------------
/// Model for collecting movie data provider
/// ------------------------------------------------------------
class MovieData extends ChangeNotifier {
  /// ------------------------------------------------------
  /// Initialize
  /// ------------------------------------------------------
  NetworkHelper networkHelper;
  LocalSaveHelper localHelper;

  MovieData({
    required this.networkHelper,
    required this.localHelper,
  });

  /// ------------------------------------------------------
  /// For Query
  /// ------------------------------------------------------
  List<Movie> _queryResult = [];

  bool get isResultEmpty => _queryResult.isEmpty;

  bool _stillQuery = false;

  bool get queryState => _stillQuery;
  void toggleQueryState() => _stillQuery = !_stillQuery;

  bool _hasError = false;
  bool get hasError => _hasError;

  Future<List<Movie>?> getQueryList(String queryString, int? page) async {
    try {
      Map? apiReturn =
          await networkHelper.getData(query: queryString, page: page);

      var result = apiReturn!["results"] as List;

      return result.map((data) => Movie.fromJson(data)).toList();
    } catch (e) {
      _hasError = true;
      notifyListeners();
    }
    return null;
  }

  Future<bool> queryMovieByPage(String queryString, int page) async {
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

  /// ------------------------------------------------------
  /// For favorite
  /// ------------------------------------------------------

  List<Movie> _favoriteMovies = [];

  bool inFavorite(Movie movie) => (_favoriteMovies.firstWhereOrNull(
        (element) => element.movieName == movie.movieName,
      ) !=
      null);

  Future<void> initLoadFavorites() async {
    List result = await localHelper.readObjectList();
    _favoriteMovies = result.map((data) => Movie.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> addFavorite(Movie newFavorite) async {
    _favoriteMovies.add(newFavorite);
    await localHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  Future<void> removeFavorite(Movie removeMovie) async {
    _favoriteMovies
        .removeWhere((element) => element.movieName == removeMovie.movieName);
    await localHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  Future<bool> updateFavorite() async {
    try {
      List<Movie> tempFavoriteList = [];
      // loop through movie in favorite
      for (var favMovie in _favoriteMovies) {
        List<Movie>? receivedQueryResult =
            await getQueryList(favMovie.movieName, null);
        if (receivedQueryResult != null) {
          // after find the updated version, update it
          Movie? updatedFavMovie = receivedQueryResult.firstWhereOrNull(
            (element) => element.movieName == favMovie.movieName,
          );
          if (updatedFavMovie != null) {
            tempFavoriteList.add(updatedFavMovie);
          }
        }
      }
      // Clear memory and then get updated version of favorite movies list
      _favoriteMovies.clear();
      _favoriteMovies = tempFavoriteList;
    } catch (e) {
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  /// ------------------------------------------------------
  /// For Both Query & Favorite
  /// ------------------------------------------------------
  Movie getMovie({required int index, required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies[index] : _queryResult[index];

  int movieCount({required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies.length : _queryResult.length;
}
