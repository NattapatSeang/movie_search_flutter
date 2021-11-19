import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

class SearchTextField extends StatelessWidget {
  final Function onTap;

  SearchTextField({required this.onTap});

  final _fieldText = TextEditingController();

  void clearText() {
    _fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) async {
        Provider.of<SearchData>(context, listen: false).addSearchHistory(value);
        Provider.of<MovieData>(context, listen: false).toggleQueryState();
        if (await Provider.of<MovieData>(context, listen: false)
            .queryMovie(value, 1)) {
          Provider.of<MovieData>(context, listen: false).toggleQueryState();
          Navigator.pushNamed(context, MovieListScreen.id);
        }
      },
      onTap: () {
        onTap();
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black54,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        enabledBorder: kSearchFieldOutline,
        focusedBorder: kSearchFieldOutline,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(bottom: 0.7),
          // Icon to
          icon: kClearIcon, // clear text
          onPressed: () {
            clearText();
          },
        ),
      ),
      controller: _fieldText,
    );
  }
}
