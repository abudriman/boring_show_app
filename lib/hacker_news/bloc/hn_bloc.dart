import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../article.dart';
import '../../util/http_helper.dart';

class HackerNewsBloc {
  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();
  final _baseUrl = 'https://hacker-news.firebaseio.com/v0';
  var _articles = <Article>[];

  HackerNewsBloc() {
    log('HackerNewsBloc created');
    _getIds().then((_) {
      _articlesSubject.add(UnmodifiableListView(_articles));
    });
  }

  Future _getIds() async {
    final res = await HttpController.getUrl(_baseUrl + '/beststories.json');
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
    _articlesSubject.close().then((value) => log('HackerNewsBloc disposed'));
  }
}
