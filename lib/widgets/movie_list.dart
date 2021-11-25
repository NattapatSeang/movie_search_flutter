import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';

import 'movie_tile.dart';

/// ------------------------------------------------------------
/// Widget class for movie list builder
/// ------------------------------------------------------------
class MovieList extends StatefulWidget {
  /// put this as false if it's used for query. true if for favorite
  final bool forFavorite;

  const MovieList({required this.forFavorite});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  /// Controller for scroll down
  final _controller = ScrollController();

  /// Increment page
  int pageShow = 1;

  /// Check if it have more
  bool haveMore = true;

  @override
  void initState() {
    super.initState();
    pageShow = 1;

    // Setup the listener.
    _controller.addListener(() async {
      // If user scroll down to almost the bottom of list, get new page
      if (_controller.position.pixels <= _controller.position.maxScrollExtent &&
          _controller.position.pixels >
              _controller.position.maxScrollExtent - 24) {
        pageShow++;
        String queryString =
            Provider.of<SearchData>(context, listen: false).currentSearch;
        if (await Provider.of<MovieData>(context, listen: false)
            .queryMovieByPage(queryString, pageShow)) {
          haveMore = true;
        } else {
          haveMore = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(builder: (context, movieData, child) {
      return ListView.builder(
        controller: _controller,
        itemBuilder: (context, index) {
          // Reserve the last row to show loading indicator
          if (index ==
              movieData.movieCount(isFromFavorite: widget.forFavorite)) {
            if (widget.forFavorite) {
              return Container();
            } else {
              return haveMore // Does it have more page?
                  ? movieData.isResultEmpty // Is result empty in first page?
                      ? movieData.queryState // Is it still query?
                          ? Container() // If it's still query
                          : const Center(
                              child: Text("No data"), // If first page empty
                            )
                      : const CupertinoActivityIndicator(
                          radius: 24, // If it have more page
                        )
                  : const Center(
                      child: Text("No more data"), // If no data in page 2++
                    );
            }
          } else {
            return Column(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    // Once pressed, it will show the information of that movie
                    Navigator.pushNamed(
                      context,
                      MovieDetailScreen.id,
                      arguments: movieData.getMovie(
                        index: index,
                        isFromFavorite: widget.forFavorite,
                      ),
                    );
                  },
                  child: MovieTile(
                    movie: movieData.getMovie(
                      index: index,
                      isFromFavorite: widget.forFavorite,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 0.7,
                  color: Colors.grey[300],
                )
              ],
            );
          }
        },
        itemCount: Provider.of<MovieData>(context)
                .movieCount(isFromFavorite: widget.forFavorite) +
            1,
      );
    });
  }
}
