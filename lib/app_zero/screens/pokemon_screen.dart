import 'package:boring_show_app/app_zero/controller/pokemon_controller.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                        image: NetworkImage(_.pokemon.value!.sprites['other']
                            ['official-artwork']['front_default'])),
                    Text(_.pokemon.value!.name),
                  ],
                ),
              ),
      ),
    );
  }
}
