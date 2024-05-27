import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/app/components/card_widget.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_store.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  late final PokemonStore store;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store = Provider.of<PokemonStore>(context, listen: false);
    _searchController.addListener(_onSearchChanged);
    store.getPokemons(); // Fetch Pokémon data initially
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    store.filterPokemons(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
              child: Hero(
                tag: 'imageSplash',
                child: Image.asset('./assets/pokemon_logo.png'),
              ),
            ),
            const SizedBox(width: 20),
            const Text('PokeFlutter'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Pesquise um Pokemon',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                if (store.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (store.erro.isNotEmpty) {
                  return Center(
                    child: Text(
                      store.erro,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                final filteredPokemon = store.filteredPokemons;
                if (filteredPokemon.isEmpty) {
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
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Colunas
                      crossAxisSpacing: 0, // Entre Colunas
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredPokemon.length,
                    itemBuilder: (_, index) {
                      final item = filteredPokemon[index];
                      final itemCount = index + 1;

                      final String primaryType =
                          item.types.isNotEmpty ? item.types[0].name : 'normal';

                      final Color colorCard =
                          AppColors.typeColors[primaryType] ?? Colors.grey;

                      return CardPokemon(
                        key: ValueKey(item.key),
                        colorType: colorCard,
                        name: item.name,
                        url: item.url,
                        image: item.image,
                        id: itemCount,
                        weight: item.weight,
                        height: item.height,
                        types: item.types,
                        abilities: item.abilities,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
