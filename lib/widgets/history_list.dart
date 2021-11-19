import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:provider/provider.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(builder: (context, movieData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TextButton(
            onPressed: () {
              print(movieData.getSearchHistory(index));
            },
            child: Text(
              movieData.getSearchHistory(index),
            ),
          );
        },
        itemCount: Provider.of<MovieData>(context).historyCount,
      );
    });
  }
}
