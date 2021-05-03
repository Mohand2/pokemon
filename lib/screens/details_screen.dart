import 'package:flutter/material.dart';
import 'package:pokemon_app/models/poke_hub.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsScreen({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pokemon.name}'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('${pokemon.name}'),
      ),
    );
  }
}
