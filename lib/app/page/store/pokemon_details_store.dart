import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/app/data/http/exceptions.dart';

import '../../data/models/pokemon_model.dart';
import '../../data/repositories/pokemon_detail_repository.dart';

part 'pokemon_details_store.g.dart';

class PokeDetailsStore = _PokeDetailsStore with _$PokeDetailsStore;

abstract class _PokeDetailsStore with Store {
  final IPokemonDetailRepository repository;

  _PokeDetailsStore({required this.repository});

  @observable
  bool isLoading = false;

  @observable
  String erro = '';

  @observable
  PokemonModel? state;

  @action
  Future getPokemonDetails() async {
    isLoading = true;

    try {
      final result = await repository.getPokemonDetails();
      state = result;
    } on NotFoundException catch (e) {
      erro = e.message;
    } catch (e) {
      erro = e.toString();
    }
    isLoading = false;
  }
}
