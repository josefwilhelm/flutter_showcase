import 'dart:convert' as convert;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/models/Insta.dart';

class HashtagRepository {
  static const String INSTAGRAM_SEARCH_URL =
      'https://www.instagram.com/web/search/topsearch/?&query=%23';

  Map _selectedHashtags = Map();

  Map<DateTime, List<HashtagItem>> _favouriteHashtags = {
    DateTime.now(): List<HashtagItem>.filled(
      30,
      HashtagItem("hello", 123),
    )
  };

  Future<HashtagSearchResponse> getHashtagsFor(String searchTerm) async {
    final response = await http.get('$INSTAGRAM_SEARCH_URL$searchTerm');

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return HashtagSearchResponse.fromJson(jsonResponse);
    } else {
      print("Request failed with status: ${response.statusCode}.");
      return HashtagSearchResponse();
    }
  }

  Future<Map<DateTime, List<HashtagItem>>> get favouriteHashtags =>
      Future.value(_favouriteHashtags);
}
