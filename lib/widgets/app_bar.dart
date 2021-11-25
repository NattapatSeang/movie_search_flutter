import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/screens/favorite_movie_screen.dart';
import 'package:movie_search/screens/search_screen.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Widget for app bar
/// ------------------------------------------------------------
class ReusableAppBar {
  /// Back button for appbar
  static Widget _backButton(BuildContext context) {
    return TextButton(
      child: RichText(
        text: const TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.arrow_back_ios, size: 18),
            ),
            TextSpan(
              text: "Back",
              style: kBlueText,
            ),
          ],
        ),
      ),
      onPressed: () {
        if (!Provider.of<MovieData>(context, listen: false).queryState) {
          Navigator.pop(context);
        }
      },
    );
  }

  /// app bar with favorite button
  static AppBar withFavorite(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF8F8F8),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, FavoriteScreen.id);
              },
              child: const Text(
                "Favorite",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// app bar with back button
  static AppBar withBack(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF8F8F8),
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: _backButton(context),
      ),
    );
  }

  /// app bar with back and toSearch button
  static AppBar withBackAndToSearch(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF8F8F8),
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: _backButton(context),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: TextButton(
              onPressed: () {
                Navigator.popUntil(
                    context, ModalRoute.withName(SearchScreen.id));
              },
              child: const Text(
                "Back to Search",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
