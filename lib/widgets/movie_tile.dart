import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie.dart';

/// ------------------------------------------------------------
/// Movie tile for each entry in movie list
/// ------------------------------------------------------------
class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 6,
              top: 8,
              bottom: 8,
            ),
            child: movie.getImage(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 18,
              top: 8,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextOneLine(
                  movie.movieName,
                  overflow: TextOverflow.ellipsis,
                  style: boldBlackTextStyle,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  movie.releaseDate,
                  style: greyTextStyle,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  movie.overview,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: smallBlackTextStyle,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
