// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonStore on _PokemonStore, Store {
  Computed<int>? _$countPokemonComputed;

  @override
  int get countPokemon =>
      (_$countPokemonComputed ??= Computed<int>(() => super.countPokemon,
              name: '_PokemonStore.countPokemon'))
          .value;
  Computed<List<PokemonModel>>? _$filteredPokemonsComputed;

  @override
  List<PokemonModel> get filteredPokemons => (_$filteredPokemonsComputed ??=
          Computed<List<PokemonModel>>(() => super.filteredPokemons,
              name: '_PokemonStore.filteredPokemons'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: '_PokemonStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$stateAtom = Atom(name: '_PokemonStore.state', context: context);

  @override
  List<PokemonModel> get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(List<PokemonModel> value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$erroAtom = Atom(name: '_PokemonStore.erro', context: context);

  @override
  String get erro {
    _$erroAtom.reportRead();
    return super.erro;
  }

  @override
  set erro(String value) {
    _$erroAtom.reportWrite(value, super.erro, () {
      super.erro = value;
    });
  }

  late final _$searchPokemonAtom =
      Atom(name: '_PokemonStore.searchPokemon', context: context);

  @override
  String get searchPokemon {
    _$searchPokemonAtom.reportRead();
    return super.searchPokemon;
  }

  @override
  set searchPokemon(String value) {
    _$searchPokemonAtom.reportWrite(value, super.searchPokemon, () {
      super.searchPokemon = value;
    });
  }

  late final _$getPokemonsAsyncAction =
      AsyncAction('_PokemonStore.getPokemons', context: context);

  @override
  Future<void> getPokemons() {
    return _$getPokemonsAsyncAction.run(() => super.getPokemons());
  }

  late final _$_PokemonStoreActionController =
      ActionController(name: '_PokemonStore', context: context);

  @override
  void setSearchPokemon(String pokemon) {
    final _$actionInfo = _$_PokemonStoreActionController.startAction(
        name: '_PokemonStore.setSearchPokemon');
    try {
      return super.setSearchPokemon(pokemon);
    } finally {
      _$_PokemonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterPokemons(String pokemon) {
    final _$actionInfo = _$_PokemonStoreActionController.startAction(
        name: '_PokemonStore.filterPokemons');
    try {
      return super.filterPokemons(pokemon);
    } finally {
      _$_PokemonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
state: ${state},
erro: ${erro},
searchPokemon: ${searchPokemon},
countPokemon: ${countPokemon},
filteredPokemons: ${filteredPokemons}
    ''';
  }
}
