import 'package:flutter/material.dart';
import 'package:movie_search/widgets/app_bar.dart';
import 'package:movie_search/widgets/movie_list.dart';

class FavoriteScreen extends StatelessWidget {
  static const String id = "favorite";
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar.withBack(context),
      body: SafeArea(
        child: Container(
          child: MovieList(forFavorite: true),
        ),
      ),
    );
  }
}
