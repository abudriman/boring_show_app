import '../controller/controller.dart';
import 'package:flutter/material.dart';
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
                        return Future.delayed(Duration(seconds: 1));
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

  List<Widget> _getListItem(PokeAPIController _) {
    return _.pokemons.value!.pokemonList
        .map<Widget>((item) => ExpansionTile(
              title: Text(item.name.capitalizeFirst!),
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
