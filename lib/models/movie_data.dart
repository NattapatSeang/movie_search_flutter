import 'package:flutter/foundation.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/services/networking.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieData extends ChangeNotifier {
  /// Network helper: for query purpose
  NetworkHelper helper = NetworkHelper();

  /// List of favorite movies
  List<Movie> _favoriteMovies = [];

  void addFavorite(Movie newFavorite) {
    _favoriteMovies.add(newFavorite);
    notifyListeners();
  }

  void removeFavorite(Movie removeMovie) {
    _favoriteMovies.remove(removeMovie);
    notifyListeners();
  }

  /// List of query result -> return true if query is success.
  List<Movie> _queryResult = [
    Movie(
        posterPath: '/r7XF6duZy5ZXmOX7HE3fKGV1WLN.jpg',
        movieName: 'adff',
        releaseDate: '1999-22-22',
        overview: 'hekko',
        voteAvg: 2)
  ];

  /// Query from search string
  bool _stillQuery = false;
  bool get queryStage => _stillQuery;
  void toggleQueryState() => _stillQuery = !_stillQuery;

  Future<bool> queryMovie(String queryString, int page) async {
    Map apiReturn = await helper.getData(query: queryString, page: page);

    if (apiReturn != null) {
      var result = apiReturn["results"] as List;
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
