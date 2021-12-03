import 'package:flutter/material.dart';

const String apiStartURL =
    "http://scb-movies-api.herokuapp.com/api/movies/search?";

const Map<String, String> apiAuthHeader = {
  'api-key': '623e6b5af5614d7debb532e0472b85c2997e5400'
};

const String imageLinkStartURL = "https://image.tmdb.org/t/p/w92";

const int maxSearchHistory = 5;

// blue text style
const blueTextStyle = TextStyle(
  color: Colors.blue,
  fontSize: 16,
);

const greyTextStyle = TextStyle(
  color: Colors.blueGrey,
  fontSize: 16,
);

const smallBlackTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const middleBlackTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
);

const whiteTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

const boldBlackTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const clearIcon = CircleAvatar(
  backgroundColor: Colors.black54,
  radius: 8,
  child: Icon(
    Icons.clear_rounded,
    color: Colors.white,
    size: 12,
  ),
);

const searchFieldOutline = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);
