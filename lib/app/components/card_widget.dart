import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/models/abilities_pokemon_model.dart';
import '../data/models/pokemon_model.dart';
import '../data/models/types_pokemon_model.dart';
import '../page/details/details_view.dart';

class CardPokemon extends StatelessWidget {
  final String name;
  final Color? colorType;
  final String url;
  final String image;
  final int id;
  final int weight;
  final int height;
  final List<TypesPokemon> types;
  final List<AbilitiesPokemon> abilities;

  const CardPokemon(
      {super.key,
      this.colorType,
      required this.name,
      required this.url,
      required this.image,
      required this.id,
      required this.weight,
      required this.height,
      required this.types,
      required this.abilities});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPokemonView(
              model: PokemonModel(
                name: name,
                url: url,
                image: image,
                id: id,
                weight: 0,
                height: 0,
                types: [],
                abilities: [],
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20, left: 20),
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: ColoredBox(
            color: colorType ?? Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 12, left: 12, top: 30, bottom: 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SvgPicture.network(
                      image,
                      height: 100,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Column(
                        children: [
                          Text(
                            name.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: types.length,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    types[index].name,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
