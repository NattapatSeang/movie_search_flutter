import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';

class Movie {
  final String posterPath;
  final String movieName;
  final String releaseDate;
  final String overview;
  final double voteAvg;

  Movie({
    required this.posterPath,
    required this.movieName,
    required this.releaseDate,
    required this.overview,
    required this.voteAvg,
  });

  Image getImage() => posterPath != "null"
      ? Image.network(kImageGetUrl + posterPath)
      : Image.asset("images/noPoster.jpg");

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      posterPath: json['poster_path'] ?? "null",
      movieName: json['title'],
      releaseDate: json['release_date'] ?? "No date",
      overview: json['overview'] ?? "No overview",
      voteAvg: json['vote_average'].toDouble(),
    );
  }
}
