import 'package:flutter/material.dart';

// start url for api
const String kStartUrl =
    "http://scb-movies-api.herokuapp.com/api/movies/search?";
// authen header
const Map<String, String> kAuthHeader = {
  'api-key': '623e6b5af5614d7debb532e0472b85c2997e5400'
};
// string for image url
const String kImageGetUrl = "https://image.tmdb.org/t/p/w92";

// blue text style
const kBlueText = TextStyle(
  color: Colors.blue,
  fontSize: 16,
);

const kGreyText = TextStyle(
  color: Colors.blueGrey,
  fontSize: 16,
);

const kBlackTextSmall = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const kBlackText = TextStyle(
  color: Colors.black,
  fontSize: 16,
);

const kWhiteText = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

const kMovieTitle = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kClearIcon = CircleAvatar(
  backgroundColor: Colors.black54,
  radius: 8,
  child: Icon(
    Icons.clear_rounded,
    color: Colors.white,
    size: 12,
  ),
);

const kSearchFieldOutline = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.white, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);
