import 'package:flutter/material.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchData>(builder: (context, searchData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return TextButton(
            onPressed: () {
              print(searchData.getSearchHistory(index));
            },
            child: Text(
              searchData.getSearchHistory(index),
            ),
          );
        },
        itemCount: Provider.of<SearchData>(context).historyCount,
      );
    });
  }
}
