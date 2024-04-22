class TypesPokemon {
  final String name;

  TypesPokemon({required this.name});
  static List<TypesPokemon> jsonToModel(json) {
    List<TypesPokemon> typesList = [];
    for (var entity in json) {
      typesList.add(TypesPokemon(name: entity['type']['name']));
    }
    return typesList;
  }
}
