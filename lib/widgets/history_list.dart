import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Widget class for history list builder
/// ------------------------------------------------------------
class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Consumer<SearchData>(builder: (context, searchData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    // Query when pressed on history text
                    Provider.of<SearchData>(context, listen: false)
                        .setCurrentSearch(searchData.getSearchHistory(index));
                    Navigator.pushNamed(context, MovieListScreen.id);
                  },
                  child: Text(
                    searchData.getSearchHistory(index),
                    style: kBlackText,
                  ),
                ),
                const Divider(
                  height: 0,
                  color: Colors.grey,
                ),
              ],
            );
          },
          itemCount: Provider.of<SearchData>(context).historyCount,
        );
      }),
    );
  }
}
