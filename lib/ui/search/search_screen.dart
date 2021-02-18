import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/pokemon_bloc.dart';
import 'package:pokemon/ui/search/components/info_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  String pokimonName;
  bool chekedButton = false;

  @override
  Widget build(BuildContext context) {
    PokemonBloc _bloc = BlocProvider.of<PokemonBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    width: 1,
                    color: Colors.yellow,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextField(
                          controller: _searchController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            border: InputBorder.none,
                            hintText: 'Введите имя покемона',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          chekedButton = true;
                          pokimonName = _searchController.text;
                          _bloc.add(SendRequestEvent(pokemonName: pokimonName));
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.yellow,
                        ),
                        child: Center(
                          child: Text(
                            "НАЙТИ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    )
                  ],
                ),
              ),
            ),
            chekedButton
                ? BlocBuilder<PokemonBloc, PokemonState>(
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
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
