class PokemonModel {
  final String name;
  final String url;
  // final Image imagePokemon;
  // final int id;
  // final double weight;
  // final int height;
  // final List types;
  // final List abilities;

  PokemonModel({
    required this.name,
    // required this.imagePokemon,
    // required this.id,
    // required this.weight,
    // required this.types,
    // required this.abilities,
    required this.url,
    // required this.height,
  });

  factory PokemonModel.fromMap(Map<String, dynamic> map) {
    return PokemonModel(
      url: map['url'],
      //height: map['height'],
      name: map['name'],
      //imagePokemon: map['imagePokemon'],
      //id: map['id'],
      //weight: map['weight'],
      //types: List<Map>.from((map['types'] as List)),
      //abilities: List<Map>.from((map['abilities'] as List))
    );
  }
}
