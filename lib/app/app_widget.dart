import 'package:flutter/material.dart';
import 'package:pokedex_flutter/app/data/http/http_client.dart';
import 'package:pokedex_flutter/app/data/repositories/pokemon_repository.dart';

import 'package:pokedex_flutter/app/page/splash/splash_view.dart';
import 'package:pokedex_flutter/app/page/store/pokemon_store.dart';
import 'package:provider/provider.dart';

import 'page/home/pokedex_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PokemonStore>(
            create: (_) => PokemonStore(
                repository: PokemonRepository(client: HttpClient())))
      ],
      child: MaterialApp(
        title: 'PokeFlutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        routes: {
          '/': (_) => const SplashView(),
          '/home': (_) => const PokedexView(),
        },
      ),
    );
  }
}
