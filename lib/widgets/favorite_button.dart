import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Widget class for favorite button
/// ------------------------------------------------------------
class FavoriteButton extends StatefulWidget {
  final Movie movie;

  const FavoriteButton({Key? key, required this.movie}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  void updateFavorite() async {
    if (isFavorite) {
      await Provider.of<MovieData>(context, listen: false)
          .removeFavorite(widget.movie);
    } else {
      await Provider.of<MovieData>(context, listen: false)
          .addFavorite(widget.movie);
    }
    setIsFavorite();
  }

  void setIsFavorite() {
    setState(() {
      isFavorite = Provider.of<MovieData>(context, listen: false)
          .inFavorite(widget.movie);
    });
  }

  @override
  void initState() {
    super.initState();
    setIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        updateFavorite();
      },
      child: Container(
        color: const Color(0xffff9200),
        child: Center(
          child: Text(
            Provider.of<MovieData>(context, listen: false)
                    .inFavorite(widget.movie)
                ? "Unfavorite"
                : "Favorite",
            style: whiteTextStyle,
          ),
        ),
      ),
    );
  }
}
