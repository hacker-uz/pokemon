part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent {}

class LoadingEvent extends PokemonEvent {}

class SendRequestEvent extends PokemonEvent {
  final String pokemonName;

  SendRequestEvent({this.pokemonName}) : assert(pokemonName != null);
}

class RandomPokemonEvent extends PokemonEvent {
  final int id;

  RandomPokemonEvent(this.id);
}