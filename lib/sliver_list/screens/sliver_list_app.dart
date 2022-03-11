import 'package:flutter/material.dart';

class SliverListApp extends StatelessWidget {
  const SliverListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.deepPurple,
            leading: const Icon(Icons.menu),
            centerTitle: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Colors.pink),
              title: const Text('S L I V E R A P P B A R'),
              centerTitle: true,
            ),
          ),
          Builder(builder: (context) {
            List<String> items = ['a', 'b', 'c', 'd'];
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 400,
                        color: Colors.deepPurple,
                        child: Center(child: Text(items[index])),
                      ),
                    ),
                  );
                },
                findChildIndexCallback: (key) => null,
                childCount: items.length, // 1000 list items
              ),
            );
          }),
          const SliverAppBar(
            backgroundColor: Colors.green,
            title: Text('Have a nice day'),
            pinned: true,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.green[100 * (index % 9 + 1)],
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(
                      "Item $index",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                );
              },
              childCount: 10, // 1000 list items
            ),
          ),
        ],
      ),
    );
  }
}
