import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../article.dart';
import '../../util/http_helper.dart';

enum StoriesType { topStories, newStories }

class HackerNewsBloc {
  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;
  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  final _storiesTypeController = StreamController<StoriesType>();
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  final _baseUrl = 'https://hacker-news.firebaseio.com/v0';
  var _articles = <Article>[];
  var isLoading = true;

  HackerNewsBloc() {
    log('HackerNewsBloc created');
    _getIds('topstories').then((_) {
      _articlesSubject.add(UnmodifiableListView(_articles));
      isLoading = false;
    });

    _storiesTypeController.stream.listen((storiesType) {
      isLoading = true;
      if (storiesType == StoriesType.newStories) {
        _getIds('newstories').then((_) {
          _articlesSubject.add(UnmodifiableListView(_articles));
          isLoading = false;
        });
      } else {
        _getIds('topstories').then((_) {
          _articlesSubject.add(UnmodifiableListView(_articles));
          isLoading = false;
        });
      }
    });
  }

  Future _getIds(String stories) async {
    final res = await HttpController.getUrl(
        _baseUrl + '/$stories.json?limitToFirst=10&orderBy="\$key"');
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return _getArticles(data);
    } else {
      return null;
    }
  }

  Future _getArticles(List ids) async {
    final futureArticle = ids.map((id) => _getArticle(id));
    final articles = await Future.wait(futureArticle);
    _articles = articles;
  }

  Future<Article> _getArticle(int id) async {
    final res = await HttpController.getUrl(_baseUrl + '/item/$id.json');
    if (res.statusCode == 200) {
      return Article.fromJson(res.body);
    } else {
      return Article(id: 1, title: 'Error');
    }
  }

  void dispose() {
    _articlesSubject.close();
    _storiesTypeController.close();
    log('HackerNewsBloc disposed');
  }
}
