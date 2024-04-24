import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/app/components/card_details.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_detail_repository.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_details_store.dart';

import '../../data/models/pokemon_model.dart';

class DetailsPokemonView extends StatefulWidget {
  final PokemonModel model;
  const DetailsPokemonView({super.key, required this.model});

  @override
  State<DetailsPokemonView> createState() => _DetailsPokemonViewState();
}

class _DetailsPokemonViewState extends State<DetailsPokemonView> {
  late final PokeDetailsStore store;

  @override
  void initState() {
    super.initState();
    store = PokeDetailsStore(
      repository: PokemonRepository(client: HttpClient(), model: widget.model),
    );
    store.getPokemonDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) {
            if (store.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (store.erro.isNotEmpty) {
              return Text(
                store.erro,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              );
            } else {
              PokemonModel entity = store.state!;

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardDetails(
                        name: entity.name,
                        url: entity.url,
                        image: entity.image,
                        id: entity.id,
                        weight: entity.weight,
                        height: entity.height,
                        types: entity.types,
                        abilities: entity.abilities),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
