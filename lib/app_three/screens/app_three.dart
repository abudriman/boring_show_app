import 'dart:convert';

import 'package:boring_show_app/app_three/article.dart';
import 'package:boring_show_app/util/http_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppThree extends StatefulWidget {
  const AppThree({Key? key}) : super(key: key);

  @override
  State<AppThree> createState() => _AppThreeState();
}

class _AppThreeState extends State<AppThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Three'),
      ),
      body: FutureBuilder<List<Article>?>(
          future: _getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.map((article) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExpansionTile(
                        key: Key(article.id.toString()),
                        title: Text(article.title!),
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(article.type!),
                              IconButton(
                                onPressed: () async {
                                  if (!await launch(article.url!))
                                    throw 'Could not launch ${article.url}';
                                },
                                icon: const Icon(Icons.launch),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: Text('No data'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List<Article>?> _getData() async {
    const baseUrl = 'https://hacker-news.firebaseio.com/v0';
    final res = await HttpController.getUrl(baseUrl + '/beststories.json');
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as List;
      return Future.wait(data.map((id) async {
        final res = await HttpController.getUrl(baseUrl + '/item/$id.json');
        if (res.statusCode == 200) {
          return Article.fromJson(res.body);
        } else {
          return Article(id: 1, title: 'Error');
        }
      }));
    } else {
      return null;
    }
  }
}
