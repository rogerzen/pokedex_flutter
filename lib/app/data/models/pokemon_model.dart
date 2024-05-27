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
  final String? key;

  PokemonModel({
    this.key,
    required this.name,
    required this.url,
    required this.image,
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
    required this.abilities,
  });

  factory PokemonModel.fromMap(
      Map<String, dynamic> map,
      String image,
      int id,
      int weight,
      int height,
      List<TypesPokemon> types,
      List<AbilitiesPokemon> abilities) {
    return PokemonModel(
      url: map['url'],
      name: map['name'],
      key: map['name'],
      image: image,
      id: id,
      weight: weight,
      height: height,
      types: types,
      abilities: abilities,
    );
  }

  PokemonModel copyWith({
    String? name,
    String? url,
    int? id,
    String? image,
    int? weight,
    int? height,
    List<TypesPokemon>? types,
    List<AbilitiesPokemon>? abilities,
    String? key,
  }) {
    return PokemonModel(
      name: name ?? this.name,
      url: url ?? this.url,
      id: id ?? this.id,
      image: image ?? this.image,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      types: types ?? this.types,
      abilities: abilities ?? this.abilities,
      key: key ?? this.key,
    );
  }
}
