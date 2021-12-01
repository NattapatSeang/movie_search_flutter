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
  /// For favorite
  /// ------------------------------------------------------

  /// Network helper: for query purpose
  NetworkHelper helper = NetworkHelper();

  /// Local saving helper: for favorite saving
  LocalSaveHelper localHelper = LocalSaveHelper(
    toFileName: "favorite.txt",
  );

  /// List of favorite movies
  List<Movie> _favoriteMovies = [];

  /// Check if it is already in favorite
  /// - movie = which movie to check
  /// - return => true if it's in favorite. false if not.
  bool inFavorite(Movie movie) => (_favoriteMovies.firstWhereOrNull(
        (element) => element.movieName == movie.movieName,
      ) !=
      null);

  /// Load the favorite from local save and save to favorite
  void initLoadFavorites() async {
    List result = await localHelper.readObjectList();
    _favoriteMovies = result.map((data) => Movie.fromJson(data)).toList();
    notifyListeners();
  }

  /// Add new movie to favorite and save to local
  /// - newFavorite = new movie to add
  void addFavorite(Movie newFavorite) async {
    _favoriteMovies.add(newFavorite);
    await localHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  /// Remove the movie from favorite
  /// - removeMovie = remove what movie
  void removeFavorite(Movie removeMovie) async {
    _favoriteMovies
        .removeWhere((element) => element.movieName == removeMovie.movieName);
    await localHelper.writeObjectList(_favoriteMovies);
    notifyListeners();
  }

  /// Update all movie in favorite to the newest data
  /// - return => true if update successfully. false if not
  Future<bool> updateFavorite() async {
    try {
      // loop through movie in favorite
      for (var favMovie in _favoriteMovies) {
        List<Movie>? temp = await getQueryList(favMovie.movieName, null);
        if (temp != null) {
          // after find the updated version, update it
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

  /// ------------------------------------------------------
  /// For Query
  /// ------------------------------------------------------

  /// List of query result
  List<Movie> _queryResult = [];

  /// Check if query result is empty
  bool get isResultEmpty => _queryResult.isEmpty;

  /// True if currently query, False if not
  bool _stillQuery = false;

  /// Get the query state
  bool get queryState => _stillQuery;

  /// Toggle query state
  void toggleQueryState() => _stillQuery = !_stillQuery;

  /// True if it has error, false if not
  bool _hasError = false;

  /// Get the error check result
  bool get hasError => _hasError;

  /// Get query result as a list
  /// - queryString = String for query
  /// - page = for
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

  /// For continuously get movie by page
  /// - queryString = what to query
  /// - page = query page number
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

  /// Get movie from favorite list or from query result list
  /// - index = index of that movie
  /// - isFromFavorite = true if from favorite, false if from query result
  Movie getMovie({required int index, required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies[index] : _queryResult[index];

  /// Get the length of movie list from favorite/from query result
  /// - isFromFavorite = true if from favorite, false if from query result
  int movieCount({required bool isFromFavorite}) =>
      isFromFavorite ? _favoriteMovies.length : _queryResult.length;
}
