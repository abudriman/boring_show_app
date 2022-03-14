import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:boring_show_app/hacker_news/article.dart';

import '../bloc/hn_bloc.dart';

class AppThree extends StatefulWidget {
  const AppThree({Key? key}) : super(key: key);

  @override
  State<AppThree> createState() => _AppThreeState();
}

class _AppThreeState extends State<AppThree> {
  final HackerNewsBloc hnBloc = HackerNewsBloc();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hacker News'),
        leading: LoadingInfo(hnBloc: hnBloc),
        centerTitle: true,
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
        stream: hnBloc.articles,
        initialData: UnmodifiableListView<Article>([]),
        builder: (context, snapshot) {
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
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
            _currentIndex = index;
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

class LoadingInfo extends StatefulWidget {
  const LoadingInfo({
    Key? key,
    required this.hnBloc,
  }) : super(key: key);

  final HackerNewsBloc hnBloc;

  @override
  State<LoadingInfo> createState() => _LoadingInfoState();
}

class _LoadingInfoState extends State<LoadingInfo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: widget.hnBloc.isLoading,
      builder: (context, snapshot) {
        _controller.forward().then((value) => _controller.reverse());
        // if (snapshot.hasData && snapshot.data!) {
        return Center(
          child: FadeTransition(
            opacity: Tween(begin: 0.3, end: 1.0).animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
            child: const FaIcon(FontAwesomeIcons.hackerNews),
          ),
        );
        // } else {
        //   return const SizedBox.shrink();
        // }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
