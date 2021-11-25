import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/widgets/app_bar.dart';
import 'package:movie_search/widgets/favorite_button.dart';

/// ------------------------------------------------------------
/// Screen that show movie detail
/// ------------------------------------------------------------
class MovieDetailScreen extends StatelessWidget {
  static const String id = "movie_detail";
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: ReusableAppBar.withBackAndToSearch(context),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 5,
              child: FittedBox(
                child: movie.getImage(),
              ),
            ),
            Flexible(
              flex: 7,
              child: InfoBlock(movie: movie),
            ),
            Flexible(
              flex: 1,
              child: FavoriteButton(movie: movie),
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Info block for movie
class InfoBlock extends StatelessWidget {
  final Movie movie;
  const InfoBlock({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            movie.movieName,
            style: kMovieTitle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Average Votes: ${movie.voteAvg}",
            style: kBlackText,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  movie.overview,
                  style: kBlackTextSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
