import 'package:rxdart/rxdart.dart';
import 'package:tag_me/bloc/Bloc.dart';
import 'package:tag_me/models/HashtagItem.dart';
import 'package:tag_me/repositories/CategoriesRepository.dart';
import 'package:tag_me/repositories/HashtagRepository.dart';
import 'package:tag_me/service_locator/ServiceLocator.dart';

class HashtagBloc extends Bloc {
  final _hashtagRepository = sl.get<HashtagRepository>();
  var _categories = sl.get<CategoriesRepository>().categories.keys.toList();

  final BehaviorSubject<Set<HashtagItem>> _subject =
      BehaviorSubject<Set<HashtagItem>>();

  final BehaviorSubject<Map<String, bool>> _hashtagMap = BehaviorSubject();

  Map<String, HashtagItem> _selectedHashtags = Map<String, HashtagItem>();

  Map<String, HashtagItem> _pictureHashtags = Map<String, HashtagItem>();

  Map<String, Map<String, HashtagItem>> _hashtagsfromCategories = Map();

  String currentCategory = "";

  ///
  /// Interface that allows to add a new favorite movie
  ///
  BehaviorSubject<HashtagItem> _selectedAddController =
      new BehaviorSubject<HashtagItem>();
  Sink<HashtagItem> get inAddSelected => _selectedAddController.sink;

  ///
  /// Interface that allows to remove a movie from the list of favorites
  ///
  BehaviorSubject<HashtagItem> _selectedRemoveController =
      new BehaviorSubject<HashtagItem>();
  Sink<HashtagItem> get inRemoveSelected => _selectedRemoveController.sink;

  /*
  controller for all categories
   */

//  BehaviorSubject<Map<String, List<HashtagItem>>> _hashtagCategoriesController =
//  BehaviorSubject();
//  Stream<Map<String, List<HashtagItem>>> get outHashtagCategories =>
//      _hashtagCategoriesController.stream;

  BehaviorSubject<List<HashtagItem>> _hashtagCategoriesController =
      BehaviorSubject();
  Stream<List<HashtagItem>> get outHashtagCategories =>
      _hashtagCategoriesController.stream;

  BehaviorSubject<List<HashtagItem>> _pictureHashtagController =
      BehaviorSubject();
  Stream<List<HashtagItem>> get outPictureHashtag =>
      _pictureHashtagController.stream;

  /*
  only selected hashtags
   */

  BehaviorSubject<List<HashtagItem>> _selectedController =
      BehaviorSubject<List<HashtagItem>>();
//  Sink<List<HashtagItem>> get _inSelected => _selectedController.sink;
  Stream<List<HashtagItem>> get outSelected => _selectedController.stream;

  BehaviorSubject<int> _favoriteTotalController = new BehaviorSubject<int>();
  Sink<int> get _inTotalFavorites => _favoriteTotalController.sink;
  Stream<int> get outTotalFavorites => _favoriteTotalController.stream;

  HashtagBloc() {
    _selectedAddController.listen(_handleAddSelected);
    _selectedRemoveController.listen(_handleRemoveSelected);
    _getHashtags();
  }

  getHashtagsForCategory(String category) {
    currentCategory = category.toLowerCase();

    if (_hashtagsfromCategories == null ||
        _hashtagsfromCategories[currentCategory].isEmpty) {
      _hashtagCategoriesController.add(null);
    }

    _hashtagCategoriesController
        .add(_hashtagsfromCategories[currentCategory].values.toList());
  }

  getHashtagsforPictureLabel(String label) {
    _hashtagRepository.getHashtagsFor(label).asStream().listen((data) {
      data.hashtags.forEach((item) {
        _pictureHashtags[item.hashtag.name] = HashtagItem(
          item.hashtag.name,
          item.hashtag.mediaCount,
        );
      });
      _pictureHashtagController.add(_pictureHashtags.values.toList());
    });
  }

  _getHashtags() {
    _categories.forEach((category) async {
      await _hashtagRepository
          .getHashtagsFor(category)
          .asStream()
          .listen((data) {
        var _temp = Map<String, HashtagItem>();
        data.hashtags.forEach((item) {
          _temp[item.hashtag.name] = (HashtagItem(
            item.hashtag.name,
            item.hashtag.mediaCount,
          ));
        });
        _handelInitCategories(category, _temp);
      });
    });
  }

  dispose() {
    _subject.close();
//    subject.close();
  }

  BehaviorSubject<Map<String, bool>> get hashtagMap => _hashtagMap;

  void _handelInitCategories(
      String category, Map<String, HashtagItem> hashtags) {
    _hashtagsfromCategories[category] = hashtags;
  }

  void _handleAddSelected(HashtagItem item) {
    switch (item.selected) {
      case true:
        _selectedHashtags[item.name] = item;
        break;

      case false:
        _selectedHashtags.remove(item.name);
        break;
    }

    if (_pictureHashtags.containsKey(item.name)) {
      _pictureHashtags[item.name] = item;
      _pictureHashtagController.add(_selectedHashtags.isNotEmpty
          ? _pictureHashtags.values.toList()
          : null);
    }

    _hashtagsfromCategories[currentCategory][item.name] = item;
    _hashtagCategoriesController
        .add(_hashtagsfromCategories[currentCategory].values.toList());

    _updateList();
  }

  void _handleRemoveSelected(HashtagItem item) {
    _selectedHashtags.remove(item);

    _updateList();
  }

  void _updateList() {
    _selectedController.add(_selectedHashtags.values.toList());
    _inTotalFavorites.add(_selectedHashtags.values.length);
  }
}
