import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/http_helper.dart';

class PokeAPIController extends GetxController {
  final pokemons = Rx<PokemonList?>(null);
  final scrollController = Rx<ScrollController>(ScrollController());
  final isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    Map jsonDecoded;
    HttpController.getUrl('https://pokeapi.co/api/v2/pokemon/')
        .then((res) => {pokemons.value = PokemonList.fromJson(res.body)})
        .whenComplete(() => update());
    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent) {
        isLoading.value = true;
        update();
        Future.delayed(const Duration(milliseconds: 300), () {
          HttpController.getUrl(pokemons.value!.next)
              .then((res) => {
                    jsonDecoded = json.decode(res.body),
                    pokemons.value = pokemons.value!
                        .copyWith(next: jsonDecoded['next'], pokemonList: [
                      ...pokemons.value!.pokemonList,
                      ...jsonDecoded['results']
                          .map((e) => PokemonListItem.fromMap(e))
                          .toList()
                    ])
                  })
              .whenComplete(() => {isLoading.value = false, update()});
        });
      }
    });
  }
}

class PokemonList {
  final int count;
  final String next;
  final String previous;
  final List<PokemonListItem> pokemonList;

  PokemonList(this.count, this.next, this.previous, this.pokemonList);

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'pokemonList': pokemonList.map((x) => x.toMap()).toList(),
    };
  }

  factory PokemonList.fromMap(Map<String, dynamic> map) {
    return PokemonList(
      map['count']?.toInt() ?? 0,
      map['next'] ?? '',
      map['previous'] ?? '',
      List<PokemonListItem>.from(
          map['results']?.map((x) => PokemonListItem.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonList.fromJson(String source) =>
      PokemonList.fromMap(json.decode(source));

  PokemonList copyWith(
      {int? count,
      String? next,
      String? previous,
      List<PokemonListItem>? pokemonList}) {
    return PokemonList(
      count ?? this.count,
      next ?? this.next,
      previous ?? this.previous,
      pokemonList ?? this.pokemonList,
    );
  }
}

class PokemonListItem {
  final String name;
  final String url;

  PokemonListItem(this.name, this.url);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PokemonListItem.fromMap(Map<String, dynamic> map) {
    return PokemonListItem(
      map['name'] ?? '',
      map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonListItem.fromJson(String source) =>
      PokemonListItem.fromMap(json.decode(source));
}
