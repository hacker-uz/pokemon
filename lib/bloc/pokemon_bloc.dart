import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/service/http_client.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitial());

  Pokemon pokemon = null;

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    if (event is SendRequestEvent) {
      yield PokemonInitial();
      try {
        pokemon =
            await HttpClient.searchPokemon(pokemonIdOrName: event.pokemonName);
        if (pokemon != null) {
          yield LoadedState(pokemon: pokemon);
        } else {
          yield ErrorMessageState("null");
        }
      } catch (e) {
        yield ErrorMessageState(e);
      }
    }
    if(event is RandomPokemonEvent) {
      yield PokemonInitial();
      try {
        pokemon =
        await HttpClient.searchPokemon(pokemonIdOrName: event.id);
        if (pokemon != null) {
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
