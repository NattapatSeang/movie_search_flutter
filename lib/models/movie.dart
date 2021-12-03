import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';

/// ------------------------------------------------------------
/// Model for each movie
/// ------------------------------------------------------------
class Movie {
  final String posterPath;
  final String movieName;
  final String releaseDate;
  final String overview;
  final double voteAverage;

  Movie({
    required this.posterPath,
    required this.movieName,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
  });

  static String _replaceWordIfEmpty(
      {String? word, required String replacement}) {
    if (word == null || word == '') {
      return replacement;
    } else {
      return word;
    }
  }

  Image getImage() => posterPath != "null"
      ? Image.network(imageLinkStartURL + posterPath)
      : Image.asset("images/noPoster.jpg");

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      posterPath: _replaceWordIfEmpty(
        word: json['poster_path'],
        replacement: "null",
      ),
      movieName: json['title'],
      releaseDate: _replaceWordIfEmpty(
        word: json['release_date'],
        replacement: "No date",
      ),
      overview: _replaceWordIfEmpty(
        word: json['overview'],
        replacement: "No overview",
      ),
      voteAverage:
          json['vote_average'] != null ? json['vote_average'].toDouble() : 0,
    );
  }

  Map toJson() => {
        'poster_path': posterPath,
        'title': movieName,
        'release_date': releaseDate,
        'overview': overview,
        'vote_average': voteAverage,
      };
}
