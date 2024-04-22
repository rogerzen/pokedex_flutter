class AbilitiesPokemon {
  final String name;

  AbilitiesPokemon({required this.name});
  static List<AbilitiesPokemon> jsonToModelAbilities(json) {
    List<AbilitiesPokemon> typesList = [];
    for (var entity in json) {
      typesList.add(AbilitiesPokemon(name: entity['ability']['name']));
    }
    return typesList;
  }
}
