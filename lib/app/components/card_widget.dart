import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_flutter/app/config/app_colors.dart';

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

  const CardPokemon({
    super.key,
    this.colorType,
    required this.name,
    required this.url,
    required this.image,
    required this.id,
    required this.weight,
    required this.height,
    required this.types,
    required this.abilities,
  });

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
                weight: weight,
                height: height,
                types: types,
                abilities: abilities,
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorType?.withOpacity(0.8) ?? Colors.grey.shade200,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.network(
                    image,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: types.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        width: 100,
                        decoration: BoxDecoration(
                          color: colorType?.withOpacity(0.2) ?? AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: colorType ?? Colors.grey,
                          ),
                        ),
                        child: Text(
                          types[index].name,
                          style: TextStyle(
                            color: colorType ?? Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      );
                    },
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
