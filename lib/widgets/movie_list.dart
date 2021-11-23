import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/movie_detail_screen.dart';
import 'package:provider/provider.dart';

import 'movie_tile.dart';

class MovieList extends StatefulWidget {
  // Create a variable
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _controller = ScrollController();
  int pageShow = 1;
  bool haveMore = true;

  @override
  void initState() {
    super.initState();
    pageShow = 1;

    // Setup the listener.
    _controller.addListener(() async {
      if (_controller.position.pixels <= _controller.position.maxScrollExtent &&
          _controller.position.pixels >
              _controller.position.maxScrollExtent - 24) {
        pageShow++;
        String queryString =
            Provider.of<SearchData>(context, listen: false).currentSearch;
        if (await Provider.of<MovieData>(context, listen: false)
            .queryMovie(queryString, pageShow)) {
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
          if (index == movieData.movieCount(isFromFavorite: false)) {
            return haveMore
                ? const CupertinoActivityIndicator(
                    radius: 24,
                  )
                : const Center(
                    child: Text("No more data"),
                  );
          } else {
            return Column(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailScreen.id,
                      arguments: movieData.getMovie(
                        index: index,
                        isFromFavorite: false,
                      ),
                    );
                  },
                  child: MovieTile(
                    movie: movieData.getMovie(
                      index: index,
                      isFromFavorite: false,
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
        itemCount:
            Provider.of<MovieData>(context).movieCount(isFromFavorite: false) +
                1,
      );
    });
  }
}
