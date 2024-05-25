import 'dart:convert';

import 'package:pokedex_flutter/app/consts/pokeapi.dart';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/utils/get_image_pokemon.dart';

import '../models/abilities_pokemon_model.dart';
import '../models/pokemon_model.dart';
import '../models/types_pokemon_model.dart';

abstract class IPokemonReposity {
  Future<List<PokemonModel>> getPokemon();
}

class PokemonRepository implements IPokemonReposity {
  final IHttpClient client;

  PokemonRepository({required this.client});

  @override
  Future<List<PokemonModel>> getPokemon() async {
    int pokenumber = 650;

    final response =
        await client.get(url: '${PokeApi.pokemonsURL}?limit=$pokenumber');

    if (response.statusCode == 200) {
      final List<PokemonModel> pokemons = [];

      final json = jsonDecode(response.body);
      final body = json['results'];

      for (int i = 0; i < body.length; i++) {
        final pokemonUrl = body[i]['url'];
        final pokemonResponse = await client.get(url: pokemonUrl);

        if (pokemonResponse.statusCode == 200) {
          final pokemonJson = jsonDecode(pokemonResponse.body);

          final int id = pokemonJson['id'];
          final int weight = pokemonJson['weight'];
          final int height = pokemonJson['height'];

          final List<TypesPokemon> types =
              TypesPokemon.jsonToModel(pokemonJson['types']);

          final List<AbilitiesPokemon> abilities =
              AbilitiesPokemon.jsonToModelAbilities(pokemonJson['abilities']);

          final pokemonModel = PokemonModel.fromMap(
              body[i],
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg',
              id,
              weight,
              height,
              types,
              abilities);

          pokemons.add(pokemonModel);
        }
      }

      return pokemons;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url Informada não é válida');
    } else {
      throw Exception('Não foi possivel carregar os pokemons');
    }
  }
}
