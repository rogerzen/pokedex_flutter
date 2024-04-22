import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_detail_repository.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_details_store.dart';

import '../../data/models/pokemon_model.dart';
import '../home/homepage_pokedex.dart';

class DetailsPokemonView extends StatefulWidget {
  final PokemonModel model;
  const DetailsPokemonView({super.key, required this.model});

  @override
  State<DetailsPokemonView> createState() => _DetailsPokemonViewState();
}

class _DetailsPokemonViewState extends State<DetailsPokemonView> {
  late final PokeDetailStore store;

  @override
  void initState() {
    super.initState();
    store = PokeDetailStore(
      repository: PokemonRepository(client: HttpClient(), model: widget.model),
    );
    store.getPokemonDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(
                  store.erro.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              PokemonModel entity = store.value;

              return Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            (_) => const MyHomePage(),
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width - 80),
                            child: Text(
                              softWrap: true,
                              entity.name.toUpperCase(),
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
                    ],
                  ),
                  const SizedBox(height: 50),
                  SvgPicture.network(
                    widget.model.image,
                    height: 300,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    ' ID: ${entity.id.toString()}',
                    style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  Text(
                    ' Peso: ${(entity.weight) / 1000} Kg ',
                    style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  Text(
                    ' Altura: ${entity.height / 10} M',
                    style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: entity.types.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          entity.types[index].name,
                          style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: entity.abilities.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(
                          entity.abilities[index].name,
                          style: const TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.w500,
                              fontSize: 25),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
