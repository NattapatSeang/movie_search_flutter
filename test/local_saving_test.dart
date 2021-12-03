import 'package:flutter_test/flutter_test.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/services/local_saving.dart';

void main() {
  group("Local Saving", () {
    test('Should be able to write and read file', () async {
      LocalSaveHelper helper = LocalSaveHelper(
          toFileName: "local_save_test_data.json", customPath: "./test");

      List<Movie> testObject = [];
      testObject.add(Movie(
          posterPath: "posterPath1",
          movieName: "movieName1",
          releaseDate: "releaseDate1",
          overview: "overview1",
          voteAverage: 1.0));
      testObject.add(Movie(
          posterPath: "posterPath2",
          movieName: "movieName2",
          releaseDate: "releaseDate2",
          overview: "overview2",
          voteAverage: 2.0));

      await helper.writeObjectList(testObject);
      List resultJSON = await helper.readObjectList();
      List<Movie> resultObject =
          resultJSON.map((data) => Movie.fromJson(data)).toList();

      expect(resultObject.first.movieName, testObject.first.movieName);
      expect(resultObject.last.movieName, testObject.last.movieName);
    });

    test('If there is no data yet, return blank', () async {
      LocalSaveHelper helper =
          LocalSaveHelper(toFileName: "not_exist.json", customPath: "./test");

      List resultJSON = await helper.readObjectList();
      List<Movie> resultObject =
          resultJSON.map((data) => Movie.fromJson(data)).toList();

      expect(resultObject, []);
    });
  });
}
