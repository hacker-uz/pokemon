import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  String pokemonsTable = 'Pokemons';
  String pokemonId = 'id';
  String pokemonName = 'name';

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'Pokemon.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database database, int version) async {
    await database.execute(
      'CREATE TABLE $pokemonsTable($pokemonId INTEGER PRIMARY KEY, $pokemonName TEXT)',
    );
  }

  //insert pokemon
  Future<Pokemon> insertPokemon(Pokemon pokemon) async {
    Database db = await this.database;
    pokemon.id = await db.insert(pokemonsTable, pokemon.toJson());
    return pokemon;
  }

  //Запросить покемона по имени
  Future<Pokemon> chekPokemon(String name) async  {
    Database db =  await this.database;
    var val  = await db.query(pokemonsTable, where: "$pokemonName = ?", whereArgs: [name]);
    Pokemon pok;
    val.forEach((element) {
      pok = Pokemon.fromJson((element));
    });
    return pok;
  }
}
