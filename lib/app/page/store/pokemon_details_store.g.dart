// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokeDetailsStore on _PokeDetailsStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_PokeDetailsStore.isLoading', context: context);

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

  late final _$erroAtom =
      Atom(name: '_PokeDetailsStore.erro', context: context);

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

  late final _$stateAtom =
      Atom(name: '_PokeDetailsStore.state', context: context);

  @override
  PokemonModel? get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PokemonModel? value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$getPokemonDetailsAsyncAction =
      AsyncAction('_PokeDetailsStore.getPokemonDetails', context: context);

  @override
  Future<dynamic> getPokemonDetails() {
    return _$getPokemonDetailsAsyncAction.run(() => super.getPokemonDetails());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
erro: ${erro},
state: ${state}
    ''';
  }
}
