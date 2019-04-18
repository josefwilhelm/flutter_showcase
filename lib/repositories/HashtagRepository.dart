import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:tag_me/models/Insta.dart';

class HashtagRepository {
  static const String INSTAGRAM_SEARCH_URL =
      'https://www.instagram.com/web/search/topsearch/?&query=%23';

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
}
