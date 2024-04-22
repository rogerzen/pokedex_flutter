import 'package:pokedex_flutter/app/data/models/abilities_pokemon_model.dart';

import 'types_pokemon_model.dart';

class PokemonModel {
  final String name;
  final String url;
  final String image;
  final int id;
  final int weight;
  final int height;
  final List<TypesPokemon> types;
  final List<AbilitiesPokemon> abilities;

  PokemonModel({
    required this.name,
    required this.url,
    required this.image,
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
    required this.abilities,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map, String image) {
    return PokemonModel(
      url: map['url'],
      name: map['name'],
      image: image,
      id: 0,
      weight: 0,
      height: 0,
      types: [],
      abilities: [],
    );
  }
}
