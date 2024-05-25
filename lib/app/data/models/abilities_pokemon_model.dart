class AbilitiesPokemon {
  final String name;

  AbilitiesPokemon({required this.name});

  static List<AbilitiesPokemon> jsonToModelAbilities(json) {
    List<AbilitiesPokemon> abilitiesList = [];

    for (var entity in json) {
      abilitiesList.add(AbilitiesPokemon(name: entity['ability']['name']));
    }

    return abilitiesList;
  }
}
