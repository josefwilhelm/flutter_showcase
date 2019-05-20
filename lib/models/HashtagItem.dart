class HashtagItem {
  String name;
  int posts;
  bool selected;

  HashtagItem(this.name, this.posts, {this.selected = false});
}

class HashtagSet {
  List<HashtagItem> hashtags;

  HashtagSet(this.hashtags);
}
