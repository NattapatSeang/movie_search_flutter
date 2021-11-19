import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/screens/favorite_movie_screen.dart';
import 'package:movie_search/screens/search_screen.dart';

class ReusableAppBar {
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
        Navigator.pop(context);
      },
    );
  }

  static AppBar withFavorite(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xffF8F8F8),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: TextButton(
              onPressed: () {
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