import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/widgets/app_bar.dart';
import 'package:movie_search/widgets/movie_list.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Screen that show favorite list
/// ------------------------------------------------------------
class FavoriteScreen extends StatefulWidget {
  static const String id = "favorite";
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void updateFavorite() async {
    Provider.of<MovieData>(context, listen: false).toggleQueryState();
    await Provider.of<MovieData>(context, listen: false).updateFavorite();
    setState(() {
      Provider.of<MovieData>(context, listen: false).toggleQueryState();
    });
  }

  @override
  void initState() {
    super.initState();
    updateFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar.withBack(context),
      body: SafeArea(
        child: Stack(
          children: [
            const MovieList(forFavorite: true),
            Provider.of<MovieData>(context, listen: false).queryState
                ? Container(
                    color: Colors.white.withOpacity(0.4),
                    child: const SpinKitPouringHourGlassRefined(
                      color: Color(0xffff9200),
                      size: 100.0,
                    ),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
