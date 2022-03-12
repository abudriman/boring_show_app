import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:boring_show_app/hacker_news/article.dart';

import '../bloc/hn_bloc.dart';

class AppThree extends StatefulWidget {
  const AppThree({Key? key}) : super(key: key);

  @override
  State<AppThree> createState() => _AppThreeState();
}

class _AppThreeState extends State<AppThree> {
  final HackerNewsBloc hnBloc = HackerNewsBloc();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker News'),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: hnBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) {
          if (hnBloc.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
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
                              if (!await launch(article.url!)) {
                                throw 'Could not launch ${article.url}';
                              }
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
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_drop_up),
            label: 'Top Stories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: 'New Stories',
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
            if (index == 0) {
              hnBloc.storiesType.add(StoriesType.topStories);
            } else {
              hnBloc.storiesType.add(StoriesType.newStories);
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    hnBloc.dispose();
    super.dispose();
  }
}
