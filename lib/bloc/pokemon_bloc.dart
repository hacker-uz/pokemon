import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/service/db.dart';
import 'package:pokemon/service/http_client.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial());

  Pokemon pokemon = null;
  Pokemon dbPokemon = null;
  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event,) async* {
    if (event is SendRequestEvent) {
      yield PokemonInitial();
      try {
        dbPokemon = await DBProvider.db.chekPokemon(event.pokemonName);
        if (dbPokemon != null) {
          print('axaxa detka');
          yield LoadedState(pokemon: dbPokemon);
          return;
        }

        pokemon =
        await HttpClient.searchPokemon(pokemonIdOrName: event.pokemonName);
        if (pokemon != null) {
          print(pokemon.name);
          await DBProvider.db
              .insertPokemon(Pokemon(id: pokemon.id, name: pokemon.name));
          yield LoadedState(pokemon: pokemon);
        } else {
          yield ErrorMessageState("Kakoyto error");
        }
      } catch (e) {
        print(e.toString());
        yield ErrorMessageState(e);
      }
    }
    if (event is RandomPokemonEvent) {
      yield PokemonInitial();
      try {
        pokemon = await HttpClient.searchPokemon(pokemonIdOrName: event.id);
        dbPokemon = await DBProvider.db.chekPokemon(pokemon.name);
        if (dbPokemon != null) {
          print('axaxa random');
          yield LoadedState(pokemon: dbPokemon);
          return;
        }

        if (pokemon != null) {
          print(pokemon.name);
          await DBProvider.db
              .insertPokemon(Pokemon(id: pokemon.id, name: pokemon.name));
          yield LoadedState(pokemon: pokemon);
        } else {
          yield ErrorMessageState("null");
        }
      } catch (e) {
        yield ErrorMessageState(e);
      }
    }
  }
}
