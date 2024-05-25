import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/models/abilities_pokemon_model.dart';
import '../data/models/types_pokemon_model.dart';
import 'text_details.dart';

class CardDetails extends StatelessWidget {
  final Color? colorCard;
  final String name;
  final String url;
  final String image;
  final int id;
  final int weight;
  final int height;
  final List<TypesPokemon> types;
  final List<AbilitiesPokemon> abilities;
  const CardDetails(
      {super.key,
      this.colorCard,
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
    return ColoredBox(
      color: colorCard ?? Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 80),
                child: Text(
                  softWrap: true,
                  name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          SvgPicture.network(
            image,
            height: 300,
          ),
          const SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.red, height: 24),
                const Row(
                  children: [
                    Text(
                      'Informações:',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_right),
                    TextDetails(title: 'ID: ', secondText: id.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_right),
                    TextDetails(
                      title: 'Peso: ',
                      secondText: ((weight) / 1000).toString(),
                      thirdText: ' Kg',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.arrow_right),
                    TextDetails(
                      title: 'Altura: ',
                      secondText: (height / 10).toString(),
                      thirdText: ' M',
                    ),
                  ],
                ),
                const Divider(color: Colors.red, height: 24),
                const Text(
                  'Tipo:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: types.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const Icon(Icons.arrow_right),
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
                const Divider(color: Colors.red, height: 24),
                const Text(
                  'Habilidades:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: abilities.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        const Icon(Icons.arrow_right),
                        Text(
                          abilities[index].name,
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
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
