import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';

import '../../data/repositories/pokemon_detail_repository.dart';

class PokeDetailStore extends ValueNotifier {
  final IPokemonDetailRepository repository;

  // Carregando:
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // erro:
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PokeDetailStore({required this.repository}) : super(repository);

  Future getPokemonDetails() async {
    isLoading.value = true;

    try {
      final result = await repository.getPokemonDetails();
      value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }

  get countPokemon => value.length;
}
