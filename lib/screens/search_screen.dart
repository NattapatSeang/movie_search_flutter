import 'package:flutter/material.dart';
import 'package:movie_search/constants.dart';
import 'package:movie_search/models/movie_data.dart';
import 'package:movie_search/widgets/app_bar.dart';
import 'package:movie_search/widgets/history_list.dart';
import 'package:movie_search/widgets/search_text_field.dart';
import 'package:provider/provider.dart';

/// ------------------------------------------------------------
/// Screen that show search bar and search history
/// ------------------------------------------------------------
class SearchScreen extends StatefulWidget {
  static const String id = "search";

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _cancelBtnVisibility = false;

  void textFieldFocus(bool isVisible, BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    // If clicked, show cancel button. If not, hide it
    setState(() {
      _cancelBtnVisibility = isVisible;

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Get all the favorite movie that is saved locally
    Provider.of<MovieData>(context, listen: false).initLoadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        textFieldFocus(false, context);
      },
      child: Scaffold(
        appBar: ReusableAppBar.withFavorite(context),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                color: const Color(0xffC9C9CE),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 7,
                          top: 9,
                          bottom: 7,
                          right: _cancelBtnVisibility ? 0 : 7,
                        ),
                        child: SearchTextField(
                          onTap: () {
                            textFieldFocus(true, context);
                          },
                        ),
                      ),
                    ),
                    getCancelButton(context),
                  ],
                ),
              ),
              const Expanded(
                child: HistoryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Cancel button. If clicked, unfocused the search bar
  Widget getCancelButton(BuildContext context) {
    return _cancelBtnVisibility
        ? TextButton(
            onPressed: () {
              textFieldFocus(false, context);
            },
            child: const Text(
              "Cancel",
              style: blueTextStyle,
            ),
          )
        : Container();
  }
}
