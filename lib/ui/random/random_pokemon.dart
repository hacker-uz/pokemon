import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/pokemon_bloc.dart';
import 'package:pokemon/ui/search/components/info_card.dart';

class RandomPokemon extends StatefulWidget {
  @override
  _RandomPokemonState createState() => _RandomPokemonState();
}

class _RandomPokemonState extends State<RandomPokemon> {
  int randomId;

  PokemonBloc _bloc;

  @override
  void initState() {
    var rng = new Random();
    randomId = rng.nextInt(250);
    _bloc = BlocProvider.of<PokemonBloc>(context);
    _bloc.add(RandomPokemonEvent(randomId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoadedState) {
              return PokemonInfoCard(
                pokemon: state.pokemon,
              );
            }
            if (state is ErrorMessageState) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  "Не найдено",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
