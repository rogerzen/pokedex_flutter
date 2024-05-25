import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/page/home/pokedex_view.dart';
import 'package:provider/provider.dart';

import '../store/pokemon_store.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var width = 0.0;
  var height = 0.0;

  @override
  void initState() {
    final store = Provider.of<PokemonStore>(context, listen: false);
    store.getPokemons();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        setState(() {
          width = 250.0;
          height = 250.0;
        });
        final nav = Navigator.of(context);
        await Future.delayed(const Duration(seconds: 4));
        nav.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PokedexView(),
            settings: const RouteSettings(name: '/home'),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: width,
          height: height,
          child: Hero(
              tag: 'imageSplash',
              child: Image.asset('./assets/pokemon_splash.png')),
        ),
      ),
    );
  }
}
