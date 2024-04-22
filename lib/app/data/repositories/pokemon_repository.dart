import 'dart:convert';

import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';

import '../models/pokemon_model.dart';

abstract class IPokemonReposity {
  Future<List<PokemonModel>> getPokemon();
}

class PokemonRepository implements IPokemonReposity {
  final IHttpClient client;

  PokemonRepository({required this.client});

  @override
  Future<List<PokemonModel>> getPokemon() async {
    final response =
        await client.get(url: 'https://pokeapi.co/api/v2/pokemon?limit=649');

    if (response.statusCode == 200) {
      final List<PokemonModel> pokemons = [];

      final json = jsonDecode(response.body);
      final body = json['results'];

      for (int i = 0; i < body.length; i++) {
        PokemonModel pokemonmodel = PokemonModel.fromMap(body[i],
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${i + 1}.svg');
        pokemons.add(pokemonmodel);
      }

      return pokemons;
    } else if (response.statusCode == 404) {
      throw NotFoundException('A url Informada não é válida');
    } else {
      throw Exception('Não foi possivel carregar os pokemons');
    }
  }
}
