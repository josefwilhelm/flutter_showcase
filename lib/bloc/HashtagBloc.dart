import 'package:rxdart/rxdart.dart';
import 'package:tag_me/models/Insta.dart';
import 'package:tag_me/repositories/HashtagRepository.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class HashtagBloc {
  final _hashtagRepository = sl.get<HashtagRepository>();

  final BehaviorSubject<HashtagSearchResponse> _subject =
      BehaviorSubject<HashtagSearchResponse>();

  getHashtags(String searchTerm) async {
    HashtagSearchResponse response =
        await _hashtagRepository.getHashtagsFor(searchTerm);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<HashtagSearchResponse> get subject => _subject;
}
