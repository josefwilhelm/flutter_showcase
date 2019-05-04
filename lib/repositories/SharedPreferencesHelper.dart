import 'package:shared_preferences/shared_preferences.dart';
import 'package:tag_me/models/HashtagItem.dart';

class SharedPreferencesHelper {
  final String _PREFS_SAVED_HASHTAGS = "saved_hashtags";

  Future<List<HashtagItem>> getSavedHashtags() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var temp = prefs.getStringList(_PREFS_SAVED_HASHTAGS);

    return temp.map((item) => HashtagItem(item, -1));
  }

  Future<bool> setSavedHashtags(List<HashtagItem> hashtags) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var temp = List<String>();

    hashtags.forEach((item) {
      temp.add(item.name);
    });

    return prefs.setStringList(_PREFS_SAVED_HASHTAGS, temp);
  }
}
