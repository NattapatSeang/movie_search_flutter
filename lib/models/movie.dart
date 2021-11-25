import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';

/// ------------------------------------------------------------
/// Model for each movie
/// ------------------------------------------------------------
class Movie {
  final String posterPath; // Path to poster
  final String movieName; // Name of the movie
  final String releaseDate; // Movie release date
  final String overview; // Movie overview
  final double voteAvg; // Score average

  /// Constructor
  Movie({
    required this.posterPath,
    required this.movieName,
    required this.releaseDate,
    required this.overview,
    required this.voteAvg,
  });

  /// Replace the empty field with determined string
  /// - word = actual word
  /// - replacement = replace to what
  /// - return => string after replaced or the actual word
  static String _replaceWordIfEmpty(
      {String? word, required String replacement}) {
    if (word == null || word == '') {
      return replacement;
    } else {
      return word;
    }
  }

  /// Get image for this movie. Replace with placeholder if no path
  /// - return => Poster image
  Image getImage() => posterPath != "null"
      ? Image.network(kImageGetUrl + posterPath)
      : Image.asset("images/noPoster.jpg");

  /// Convert from JSON map to this type of object
  /// - json = from what json
  /// - return => Movie object to this object
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
      voteAvg:
          json['vote_average'] != null ? json['vote_average'].toDouble() : 0,
    );
  }

  /// Convert this object to json map
  /// - return => json map of this object
  Map toJson() => {
        'poster_path': posterPath,
        'title': movieName,
        'release_date': releaseDate,
        'overview': overview,
        'vote_average': voteAvg,
      };
}
