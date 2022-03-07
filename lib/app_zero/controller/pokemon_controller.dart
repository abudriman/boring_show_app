import 'dart:convert';
import 'package:get/get.dart';

import '../../util/http_helper.dart';

class PokemonController extends GetxController {
  final String url;
  final pokemon = Rx<Pokemon?>(null);

  PokemonController(this.url);

  @override
  void onInit() {
    super.onInit();
    HttpController.getUrl(url).then((res) {
      pokemon.value = Pokemon.fromJson(res.body);
      update();
    });
  }
}

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int order;
  final int weight;
  final List<PokemonAbility> abilities;
  final Map<String, dynamic> sprites;

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.abilities,
    required this.sprites,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'baseExperience': baseExperience,
      'height': height,
      'isDefault': isDefault,
      'order': order,
      'weight': weight,
      'abilities': abilities.map((x) => x.toMap()).toList(),
      'sprites': sprites,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      baseExperience: map['baseExperience']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      isDefault: map['isDefault'] ?? false,
      order: map['order']?.toInt() ?? 0,
      weight: map['weight']?.toInt() ?? 0,
      abilities: List<PokemonAbility>.from(
          map['abilities']?.map((x) => PokemonAbility.fromMap(x))),
      sprites: Map<String, dynamic>.from(map['sprites']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source));
}

class PokemonAbility {
  final Ability ability;
  final bool isHidden;
  final int slot;

  PokemonAbility({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  PokemonAbility copyWith({
    Ability? ability,
    bool? isHidden,
    int? slot,
  }) {
    return PokemonAbility(
      ability: ability ?? this.ability,
      isHidden: isHidden ?? this.isHidden,
      slot: slot ?? this.slot,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ability': ability.toMap(),
      'isHidden': isHidden,
      'slot': slot,
    };
  }

  factory PokemonAbility.fromMap(Map<String, dynamic> map) {
    return PokemonAbility(
      ability: Ability.fromMap(map['ability']),
      isHidden: map['isHidden'] ?? false,
      slot: map['slot']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonAbility.fromJson(String source) =>
      PokemonAbility.fromMap(json.decode(source));

  @override
  String toString() =>
      'PokemonAbility(ability: $ability, isHidden: $isHidden, slot: $slot)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonAbility &&
        other.ability == ability &&
        other.isHidden == isHidden &&
        other.slot == slot;
  }

  @override
  int get hashCode => ability.hashCode ^ isHidden.hashCode ^ slot.hashCode;
}

class Ability {
  final String name;
  final String url;
  Ability({
    required this.name,
    required this.url,
  });

  Ability copyWith({
    String? name,
    String? url,
  }) {
    return Ability(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory Ability.fromMap(Map<String, dynamic> map) {
    return Ability(
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ability.fromJson(String source) =>
      Ability.fromMap(json.decode(source));

  @override
  String toString() => 'Ability(name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ability && other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
