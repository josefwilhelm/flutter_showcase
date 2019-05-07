import 'package:shared_preferences/shared_preferences.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/repositories/HashtagRepository.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class SharedPreferencesHelper {
  final String _PREFS_SAVED_HASHTAGS = "saved_hashtags";

  Future<Map<DateTime, List<HashtagItem>>> getSavedHashtags() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var temp = prefs.getStringList(_PREFS_SAVED_HASHTAGS);

    Map<DateTime, List<HashtagItem>> _favouriteHashtags = {
      DateTime.now(): List<HashtagItem>.generate(temp.length,
              (index) {
            return HashtagItem(temp[index], 123);
          })
    };

    Map<DateTime, List<HashtagItem>> temp1 = {DateTime.now() : temp.map((item) => HashtagItem(item, -1))};
//    temp1[DateTime.now()] = ;

    return _favouriteHashtags;
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
