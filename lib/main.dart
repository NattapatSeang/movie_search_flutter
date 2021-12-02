import 'package:flutter/material.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/favorite_movie_screen.dart';
import 'package:movie_search/screens/movie_detail_screen.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:movie_search/screens/search_screen.dart';
import 'package:movie_search/services/local_saving.dart';
import 'package:movie_search/services/networking.dart';
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
        ChangeNotifierProvider<MovieData>(
            create: (context) => MovieData(
                  localHelper: LocalSaveHelper(
                    toFileName: "favorite.json",
                  ),
                  networkHelper: NetworkHelper(),
                )),
        ChangeNotifierProvider<SearchData>(create: (context) => SearchData()),
      ],
      child: MaterialApp(
        home: const SafeArea(
          child: MovieListScreen(),
        ),
        initialRoute: SearchScreen.id,
        routes: {
          SearchScreen.id: (context) => const SearchScreen(),
          FavoriteScreen.id: (context) => const FavoriteScreen(),
          MovieListScreen.id: (context) => const MovieListScreen(),
          MovieDetailScreen.id: (context) => const MovieDetailScreen(),
        },
      ),
    );
  }
}
