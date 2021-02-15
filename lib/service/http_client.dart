import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokemon/bloc/pokemon_bloc.dart';
import 'package:pokemon/models/pokemon.dart';

class HttpClient {
  final Client httpClient = Client();

  static const BASE_URL = "https://pokeapi.co/api/v2";

  static Future searchPokemon({dynamic pokemonIdOrName}) async {
    var response;
    var url;
    try {
      url = '$BASE_URL/ability/$pokemonIdOrName';
      response = await get(url);
      if(response.statusCode == 200) {
        print('Response body: ${json.decode(utf8.decode(response.bodyBytes))}');
        final jsonData = utf8.decode(response.bodyBytes);
        final pokemon = pokemonFromJson(jsonData);
        return pokemon;
      }
      if (response.statusCode == 404) {
        print("Not Found");
        return ErrorMessageState("Not Found");
      }
    } catch (e) {
      print(e);
      ErrorMessageState(e);
    }
  }
}
