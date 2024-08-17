import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_flutter/app/page/home/pokedex_view.dart';
import 'package:provider/provider.dart';

import '../store/pokemon_store.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final PokemonStore store;
  var width = 50.0;
  var height = 50.0;
  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    store = Provider.of<PokemonStore>(context, listen: false);
    startTime = DateTime.now();
    store.getPokemons();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        width = 250.0;
        height = 250.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (context) {
            if (store.isLoading) {
              return Center(
                child: AnimatedContainer(
                  duration: Duration(
                      milliseconds: DateTime.now().difference(startTime).inMicroseconds),
                  width: width,
                  height: height,
                  child: Hero(
                    tag: 'imageSplash',
                    child: Image.asset('./assets/pokemon_splash.png'),
                  ),
                ),
              );
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
              // Navega para a próxima tela após os Pokémons serem carregados
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final nav = Navigator.of(context);
                nav.pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                    const PokedexView(),
                    settings: const RouteSettings(name: '/home'),
                  ),
                );
              });

              // Retorna um widget vazio enquanto espera a navegação
              return Container();
            }
          },
        ),
      ),
    );
  }
}
