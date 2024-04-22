import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/app/page/details/details_view.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_store.dart';

import '../../data/models/pokemon_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PokeStore store = PokeStore(
    repository: PokemonRepository(
      client: HttpClient(),
    ),
  );
  @override
  void initState() {
    super.initState();
    store.getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'PokeFlutter',
        ),
      ),
      body: ListenableBuilder(
        listenable:
            Listenable.merge([store.isLoading, store.erro, store.state]),
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
          }
          if (store.state.value.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum Pokemon na lista',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                final itemCount = index + 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsPokemonView(
                          model: PokemonModel(
                            name: item.name,
                            url: item.url,
                            image: item.image,
                            id: itemCount,
                            weight: 0,
                            height: 0,
                            types: [],
                            abilities: [],
                          ),
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: ColoredBox(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 12, left: 12, top: 30, bottom: 30),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SvgPicture.network(
                                item.image,
                                height: 100,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  item.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
