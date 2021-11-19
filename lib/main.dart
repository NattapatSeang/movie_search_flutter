import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/screens/favorite_movie_screen.dart';
import 'package:movie_search/screens/movie_detail_screen.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:movie_search/screens/search_screen.dart';
//import 'package:movie_search/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MovieSearch());
}

class MovieSearch extends StatelessWidget {
  const MovieSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieData(),
      child: MaterialApp(
        home: SafeArea(
          child: MovieListScreen(),
        ),
        initialRoute: SearchScreen.id,
        routes: {
          SearchScreen.id: (context) => SearchScreen(),
          FavoriteScreen.id: (context) => FavoriteScreen(),
          MovieListScreen.id: (context) => MovieListScreen(),
          MovieDetailScreen.id: (context) => MovieDetailScreen(),
        },
      ),
    );
  }
}
