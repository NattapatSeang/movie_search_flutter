import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/services/local_saving.dart';
import 'package:movie_search/services/networking.dart';

import 'movie_data_test.mocks.dart';

@GenerateMocks([NetworkHelper, LocalSaveHelper])
void main() {
  /// ------------------------------------------------------
  /// Mock Variable
  /// ------------------------------------------------------
  Movie firstMockMovie = Movie(
    posterPath: "null",
    movieName: "Mock 1",
    releaseDate: "2012-01-01",
    overview: "overview1",
    voteAverage: 1.0,
  );

  Movie secondMockMovie = Movie(
    posterPath: "null",
    movieName: "Mock 2",
    releaseDate: "2012-02-02",
    overview: "overview2",
    voteAverage: 2.0,
  );

  List<Map<String, dynamic>> jsonMockMovie = [
    {
      "poster_path": "null",
      "title": "Mock 1",
      "release_date": "2012-01-01",
      "overview": "overview1",
      "vote_average": 1.0
    },
    {
      "poster_path": "null",
      "title": "Mock 2",
      "release_date": "2012-02-02",
      "overview": "overview2",
      "vote_average": 2.0
    }
  ];

  Movie firstNewMockMovie = Movie(
    posterPath: "mock_image1.jpg",
    movieName: "Mock 1",
    releaseDate: "2012-01-01",
    overview: "overview1",
    voteAverage: 1.0,
  );

  Movie secondNewMockMovie = Movie(
    posterPath: "mock_image2.jpg",
    movieName: "Mock 2",
    releaseDate: "2012-02-02",
    overview: "overview2",
    voteAverage: 2.0,
  );

  Map jsonNewMockMovie = {
    "results": [
      {
        "poster_path": "mock_image1.jpg",
        "title": "Mock 1",
        "release_date": "2012-01-01",
        "overview": "overview1",
        "vote_average": 1.0
      },
      {
        "poster_path": "mock_image2.jpg",
        "title": "Mock 2",
        "release_date": "2012-02-02",
        "overview": "overview2",
        "vote_average": 2.0
      }
    ]
  };

  /// ------------------------------------------------------
  /// For Query
  /// ------------------------------------------------------
  group("Deal with query", () {
    final MockNetworkHelper networkHelperMock = MockNetworkHelper();
    final MockLocalSaveHelper localHelperMock = MockLocalSaveHelper();

    MovieData movieData = MovieData(
      networkHelper: networkHelperMock,
      localHelper: localHelperMock,
    );

    when(networkHelperMock.getData(query: "Mock 1", page: 1))
        .thenAnswer((_) async => jsonNewMockMovie);

    when(networkHelperMock.getData(query: "Mock 3", page: 1))
        .thenThrow("Some error");

    when(networkHelperMock.getData(query: "Mock 1"))
        .thenAnswer((_) async => jsonNewMockMovie);

    test('Able to get query list from network', () async {
      List<Movie>? result = await movieData.getQueryList("Mock 1", null);

      expect(result![0].movieName, firstNewMockMovie.movieName);
      expect(result[1].movieName, secondNewMockMovie.movieName);
    });

    test('Able to query movie by page and save it to list', () async {
      bool queryResultPass = await movieData.queryMovieByPage("Mock 1", 1);
      expect(queryResultPass, true);
      expect(movieData.getMovie(index: 0, isFromFavorite: false).movieName,
          "Mock 1");
    });

    test('If query somehow fail, return as false', () async {
      bool queryResultPass = await movieData.queryMovieByPage("Mock 3", 1);
      expect(queryResultPass, false);
    });
  });

  /// ------------------------------------------------------
  /// For Favorite
  /// ------------------------------------------------------
  group("Deal with favorite", () {
    final MockNetworkHelper networkHelperMock = MockNetworkHelper();
    final MockLocalSaveHelper localHelperMock = MockLocalSaveHelper();
    MovieData movieData = MovieData(
      networkHelper: networkHelperMock,
      localHelper: localHelperMock,
    );

    /// Set up variable for stub
    when(localHelperMock.writeObjectList(any))
        .thenAnswer((_) async => File("./noExistJustMock.json"));

    when(localHelperMock.readObjectList())
        .thenAnswer((_) async => jsonMockMovie);

    when(networkHelperMock.getData(query: "Mock 1"))
        .thenAnswer((_) async => jsonNewMockMovie);

    when(networkHelperMock.getData(query: "Mock 2"))
        .thenAnswer((_) async => jsonNewMockMovie);

    /// Unit test
    test('Able to add favorite and read it', () async {
      movieData.addFavorite(firstMockMovie);
      movieData.addFavorite(secondMockMovie);

      expect(movieData.getMovie(index: 0, isFromFavorite: true).movieName,
          "Mock 1");
      expect(movieData.getMovie(index: 1, isFromFavorite: true).movieName,
          "Mock 2");
    });

    test('Able to remove favorite', () async {
      movieData.removeFavorite(firstMockMovie);

      expect(movieData.getMovie(index: 0, isFromFavorite: true).movieName,
          "Mock 2");
    });

    test('Able to get favorite from file', () async {
      await movieData.initLoadFavorites();

      expect(movieData.movieCount(isFromFavorite: true), 2);
    });

    test('Able to check if it is in favorite', () async {
      expect(movieData.inFavorite(firstMockMovie), true);
    });

    test('Able to check if it is not in favorite', () async {
      expect(
          movieData.inFavorite(Movie(
              posterPath: "null",
              movieName: "Mock 3",
              releaseDate: "2012-03-03",
              overview: " 3",
              voteAverage: 3.0)),
          false);
    });

    test('Able to update data in favorite', () async {
      await movieData.updateFavorite();

      expect(movieData.getMovie(index: 0, isFromFavorite: true).posterPath,
          "mock_image1.jpg");
      expect(movieData.getMovie(index: 1, isFromFavorite: true).posterPath,
          "mock_image2.jpg");
    });
  });
}
