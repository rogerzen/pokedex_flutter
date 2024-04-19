import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_repository.dart';

class PokeStore {
  final IPokemonReposity repository;

  // Carregando:
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // State:
  final ValueNotifier<List<PokemonModel>> state =
      ValueNotifier<List<PokemonModel>>([]);

  // erro:
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PokeStore({required this.repository});

  Future getPokemons() async {
    isLoading.value = true;

    try {
      final result = await repository.getPokemon();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  get countPokemon => state.value.length;
}
