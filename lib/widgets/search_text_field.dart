import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/search_data.dart';
import 'package:movie_search/screens/movie_list_screen.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Widget class for search text field
/// ------------------------------------------------------------
class SearchTextField extends StatelessWidget {
  final Function onTap;

  SearchTextField({Key? key, required this.onTap}) : super(key: key);

  final _fieldText = TextEditingController();

  void clearText() {
    _fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (value) async {
        // Once submit, move to query result page
        Provider.of<SearchData>(context, listen: false).setCurrentSearch(value);
        Navigator.pushNamed(context, MovieListScreen.id);
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
        enabledBorder: searchFieldOutline,
        focusedBorder: searchFieldOutline,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(bottom: 0.7),
          // Icon to
          icon: clearIcon, // clear text
          onPressed: () {
            clearText();
          },
        ),
      ),
      controller: _fieldText,
    );
  }
}
