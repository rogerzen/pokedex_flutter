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

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late final PokemonStore store;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    store = Provider.of<PokemonStore>(context, listen: false);
    store.getPokemons();

    // Configuração da animação
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -20.0, end: 20.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (context) {
            if (store.isLoading) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        left: MediaQuery.of(context).size.width / 2 - 125,
                        top: MediaQuery.of(context).size.height / 2 - 125 + _animation.value,
                        child: Hero(
                          tag: 'imageSplash',
                          child: Image.asset(
                            './assets/pokemon_splash.png',
                            width: 250,
                            height: 250,
                          ),
                        ),
                      );
                    },
                  ),
                  // Barra de progresso
                  Positioned(
                    bottom: 20.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ),
                ],
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
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const PokedexView(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Define a animação de transição
                      const begin = Offset(1.0, 0.0); // Desliza da direita para a esquerda
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

                      return SlideTransition(position: offsetAnimation, child: child);
                    },
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
