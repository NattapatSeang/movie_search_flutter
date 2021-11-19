import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/favorite_movie_screen.dart';
import 'package:movie_search/screens/movie_detail_screen.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:movie_search/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MovieSearch());
}

class MovieSearch extends StatelessWidget {
  const MovieSearch({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieData>(create: (context) => MovieData()),
        ChangeNotifierProvider<SearchData>(create: (context) => SearchData()),
      ],
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
