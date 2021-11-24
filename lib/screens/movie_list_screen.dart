import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/widgets/app_bar.dart';
import 'package:movie_search/widgets/movie_list.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatefulWidget {
  static const String id = "movie_list";
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String query = "";

  void queryMovie() async {
    Provider.of<MovieData>(context, listen: false).toggleQueryState();
    await Provider.of<MovieData>(context, listen: false).queryMovie(query, 1);
    setState(() {
      if (!Provider.of<MovieData>(context, listen: false).hasError) {
        Provider.of<SearchData>(context, listen: false).addSearchHistory(query);
      }
      Provider.of<MovieData>(context, listen: false).toggleQueryState();
    });
  }

  @override
  void initState() {
    query = Provider.of<SearchData>(context, listen: false).currentSearch;
    super.initState();
    queryMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar.withBack(context),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: MovieList(forFavorite: false),
            ),
            Provider.of<MovieData>(context, listen: false).queryStage
                ? const SpinKitPouringHourGlassRefined(
                    color: Color(0xffff9200),
                    size: 100.0,
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
