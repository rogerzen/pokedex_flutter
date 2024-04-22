import 'dart:convert';

import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/app/data/models/types_pokemon_model.dart';

import '../models/abilities_pokemon_model.dart';

abstract class IPokemonDetailRepository {
  Future<PokemonModel> getPokemonDetails();
}

class PokemonRepository implements IPokemonDetailRepository {
  final IHttpClient client;

  final PokemonModel model;

  PokemonRepository({required this.client, required this.model});

  @override
  Future<PokemonModel> getPokemonDetails() async {
    final response =
        await client.get(url: 'https://pokeapi.co/api/v2/pokemon/${model.id}');

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final pokeName = body['name'];
      final pokeId = body['id'];
      final pokeHeight = body['height'];
      final pokeWeight = body['weight'];
      final pokeTypes = body['types'];
      final pokeAbilities = body['abilities'];

      return PokemonModel(
        url: model.url,
        image: model.image,
        name: pokeName,
        id: pokeId,
        height: pokeHeight,
        weight: pokeWeight,
        types: TypesPokemon.jsonToModel(pokeTypes),
        abilities: AbilitiesPokemon.jsonToModelAbilities(pokeAbilities),
      );
    } else if (response.statusCode == 404) {
      throw NotFoundException('A URL informada não é válida');
    } else {
      throw Exception('Não foi possível carregar os Pokémon');
    }
  }
}
