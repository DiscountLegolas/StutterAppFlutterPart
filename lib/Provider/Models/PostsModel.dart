import 'package:example/Api/Models/Post.dart';
import 'package:example/Api/http.dart';
import 'package:flutter/foundation.dart';

class PostsModel extends ChangeNotifier {
  late Future<List<Post>> _posts;
  PostsModel() {
    this.setposts = HttpHelper.getposts();
  }
  Future<List<Post>> get posts => _posts;
  set setposts(Future<List<Post>> newposts) {
    _posts = newposts;
    notifyListeners();
  }

  void GetByDateTime(DateTime dateTime) {
    this.setposts = HttpHelper.getposts(dateTime: dateTime);
  }

  void GetByNameSurname(String str) {
    if (str.length <= 0) {
      this.setposts = HttpHelper.getposts();
    } else {
      this.setposts = HttpHelper.getposts(str: str);
    }
  }

  void GetByDateTimeNameSurname(DateTime dateTime, String str) {
    this.setposts = HttpHelper.getposts(dateTime: dateTime, str: str);
  }
}
