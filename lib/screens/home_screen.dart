import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/poke_hub.dart';
import 'package:pokemon_app/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PokeHub pokeHub;
  int length = 0;
  var url = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var parsedData = jsonDecode(response.body);
      pokeHub = PokeHub.fromJson(parsedData);
      setState(() {
        length = pokeHub.pokemon.length;
      });
    } else {
      print('error !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          setState(() {
            length = 0;
            fetchData();
          });
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text('Poke App'),
        elevation: 10,
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: length != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: pokeHub.pokemon.length,
                  itemBuilder: (BuildContext ctx, index) {
                    var pokemon = pokeHub.pokemon[index];
                    // print(pokeHub.pokemon[index]);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              pokemon: pokemon,
                            ),
                          ),
                        );
                      },
                      child: buildCard(pokemon: pokemon),
                    );
                  }),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            ),
    );
  }

  Widget buildCard({@required var pokemon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Hero(
        tag: pokemon.name,
        child: Card(
          elevation: 15,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pokemon.img,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '${pokemon.name}',
                style: TextStyle(fontSize: 32, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
