import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/app/components/card_widget.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_store.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  late final PokemonStore store;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store = Provider.of<PokemonStore>(context, listen: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (pokemon) {
                  store.setSearchPokemon(pokemon);
                },
                decoration: InputDecoration(
                    hintText: 'Pesquise um Pokemon',
                    hintStyle: const TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20)),
              ),
            ),
          ),
          Observer(
            builder: (context) {
              if (store.isLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (store.erro.isNotEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      store.erro,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              final filteredPokemon = store.filteredPokemons;
              if (filteredPokemon.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Nenhum Pokemon na lista',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              } else {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Numero de Pokemos por grid
                    crossAxisSpacing: 0,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 5, // entre altura cards
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                    childCount: filteredPokemon.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_upward_rounded,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}
