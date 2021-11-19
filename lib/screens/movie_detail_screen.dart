import 'package:flutter/material.dart';
import 'package:movie_search/widgets/app_bar.dart';

class MovieDetailScreen extends StatelessWidget {
  static const String id = "movie_detail";
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar.withBackAndToSearch(context),
      body: SafeArea(
        child: Container(
          child: Text("This is movie detail screen"),
        ),
      ),
    );
  }
}
