part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class LoadedState extends PokemonState {
  final Pokemon pokemon;

  LoadedState({this.pokemon});
}

class ErrorMessageState extends PokemonState {
  final message;

  ErrorMessageState(this.message);
}