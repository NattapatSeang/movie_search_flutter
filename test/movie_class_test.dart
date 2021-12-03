import 'package:flutter_test/flutter_test.dart';
import 'package:movie_search/models/movie.dart';

void main() {
  group("Object Converting", () {
    test('Able to convert from json to movie class', () {
      Map<String, dynamic> movieJSON = {
        "title": "Movie Title",
        "poster_path": "/2va32apQP97gvUxaMnL5wYt4CRB.jpg",
        "release_date": "2022-12-12",
        "overview": "Use Batman poster for test purpose",
        "vote_average": 0.1
      };

      Movie movieObject = Movie.fromJson(movieJSON);
      expect(movieObject.movieName, "Movie Title");
      expect(movieObject.overview, "Use Batman poster for test purpose");
      expect(movieObject.posterPath, "/2va32apQP97gvUxaMnL5wYt4CRB.jpg");
      expect(movieObject.releaseDate, "2022-12-12");
      expect(movieObject.voteAverage, 0.1);
    });

    test('Able to replace missing part', () {
      Map<String, dynamic> movieJSON = {
        "title": "Movie Title",
      };

      Movie movieObject = Movie.fromJson(movieJSON);
      expect(movieObject.movieName, "Movie Title");
      expect(movieObject.overview, "No overview");
      expect(movieObject.posterPath, "null");
      expect(movieObject.releaseDate, "No date");
      expect(movieObject.voteAverage, 0);
    });

    test('Able to convert from movie class to json', () {
      Movie movieObject = Movie(
          posterPath: "/2va32apQP97gvUxaMnL5wYt4CRB.jpg",
          movieName: "Movie Title",
          releaseDate: "2022-12-12",
          overview: "Use Batman poster for test purpose",
          voteAverage: 0.1);

      Map movieJSON = movieObject.toJson();
      expect(movieJSON["title"], "Movie Title");
      expect(movieJSON["overview"], "Use Batman poster for test purpose");
      expect(movieJSON["poster_path"], "/2va32apQP97gvUxaMnL5wYt4CRB.jpg");
      expect(movieJSON["release_date"], "2022-12-12");
      expect(movieJSON["vote_average"], 0.1);
    });
  });
}
