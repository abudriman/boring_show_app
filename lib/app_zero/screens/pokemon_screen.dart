import 'package:boring_show_app/app_zero/controller/pokemon_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final pokemonController =
        Get.put(PokemonController(Get.arguments), tag: 'PokemonController');
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<PokemonController>(
          tag: 'PokemonController',
          builder: (_) => _.pokemon.value == null
              ? const Text('Loading...')
              : Text(
                  '${_.pokemon.value!.name.capitalizeFirst!} (Id: ${_.pokemon.value!.id})'),
        ),
      ),
      body: GetBuilder<PokemonController>(
        tag: 'PokemonController',
        builder: (_) => _.pokemon.value == null
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: Get.height * 0.5,
                        child: CachedNetworkImage(
                          imageUrl: _.pokemon.value!.sprites['other']
                                  ['official-artwork']['front_default'] ??
                              '',
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                                Text('Error loading image'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_.pokemon.value!.name.capitalizeFirst!,
                              style: const TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold)),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListTile(
                                    title: Text('${_.pokemon.value!.height}'),
                                    subtitle: const Text('Height'),
                                  ),
                                  ListTile(
                                    title: Text('${_.pokemon.value!.weight}'),
                                    subtitle: const Text('Weight'),
                                  ),
                                  ListTile(
                                    title: Text(_.pokemon.value!.abilities
                                        .map((e) =>
                                            e.ability.name.capitalizeFirst)
                                        .toList()
                                        .join(", ")),
                                    subtitle: const Text('Abilities'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
