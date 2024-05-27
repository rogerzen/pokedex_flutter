import 'package:pokedex_flutter/app/data/http/exceptions.dart';
import 'package:pokedex_flutter/app/data/models/pokemon_model.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_repository.dart';
import 'package:mobx/mobx.dart';

part 'pokemon_store.g.dart';

class PokemonStore = _PokemonStore with _$PokemonStore;

abstract class _PokemonStore with Store {
  final IPokemonReposity repository;

  _PokemonStore({required this.repository});

  @observable
  bool isLoading = false;

  @observable
  List<PokemonModel> state = [];

  @observable
  String erro = '';

  @observable
  String searchPokemon = '';

  @computed
  int get countPokemon => state.length;

  @computed
  List<PokemonModel> get filteredPokemons {
    if (searchPokemon.isEmpty) {
      return state;
    } else {
      return state
          .where((pokemon) =>
              pokemon.name.toLowerCase().contains(searchPokemon.toLowerCase()))
          .toList();
    }
  }

  @action
  Future<void> getPokemons() async {
    isLoading = true;
    try {
      final result = await repository.getPokemon();
      state = result;
    } on NotFoundException catch (e) {
      erro = e.message;
    } catch (e) {
      erro = e.toString();
    }
    isLoading = false;
  }

  @action
  void setSearchPokemon(String pokemon) {
    searchPokemon = pokemon;
  }

  @action
  void filterPokemons(String pokemon) {
    setSearchPokemon(pokemon);
  }
}
