import 'dart:collection';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Three'),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: hnBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }

  @override
  void dispose() {
    hnBloc.dispose();
    super.dispose();
  }
}
