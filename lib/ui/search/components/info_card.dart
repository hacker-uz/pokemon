import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';

class PokemonInfoCard extends StatelessWidget {
  Pokemon pokemon;

  PokemonInfoCard({Key key, this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: Color(0xFFDFDFDF),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pokemon.name),
            Divider(
              height: 15,
              color: Color(0xFFDFDFDF),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pokemon.effectEntries.length,
                itemBuilder: (context, index) {
                  var element = pokemon.effectEntries[index].effect;
                  return Container(
                    width: double.infinity,
                    child: Text(
                      element,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
