import 'package:cached_network_image/cached_network_image.dart';

import '../controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class AppZero extends StatelessWidget {
  const AppZero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Zero'),
      ),
      body: Center(
          child: GetBuilder<PokeAPIController>(
              init: Get.put<PokeAPIController>(PokeAPIController(),
                  permanent: false),
              builder: (_) => _.pokemons.value == null
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () {
                        return Future.delayed(
                            const Duration(seconds: 1), _.fetchPokemonList);
                      },
                      child: ListView(
                        controller: _.scrollController.value,
                        children: [
                          ..._getListItem(_),
                          _.isLoading.value
                              ? const Center(
                                  child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(),
                                ))
                              : const SizedBox.shrink()
                        ],
                      ),
                    ))),
    );
  }

  String iconBaseUrl(id) {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  List<Widget> _getListItem(PokeAPIController _) {
    return _.pokemons.value!.pokemonList
        .mapIndexed<Widget>((index, item) => ExpansionTile(
              key: Key(index.toString()),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name.capitalizeFirst!),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CachedNetworkImage(
                      imageUrl: iconBaseUrl(item.id),
                      errorWidget: (context, url, error) =>
                          CachedNetworkImage(imageUrl: iconBaseUrl(0)),
                    ),
                  )
                ],
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.toNamed('/pokemon', arguments: item.url),
                          child: const Text('Go to pokemon')),
                    ),
                  ],
                ),
              ],
            ))
        .toList();
  }
}
