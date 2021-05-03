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
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
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
        elevation: 5,
        //backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: length != 0
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: pokeHub.pokemon.length,
              itemBuilder: (BuildContext ctx, index) {
                Pokemon dataItem = pokeHub.pokemon[index];
                // print(pokeHub.pokemon[index]);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          pokemon: dataItem,
                        ),
                      ),
                    );
                  },
                  child: buildCard(dataItem: dataItem),
                );
              })
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

  Widget buildCard({@required var dataItem}) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            dataItem.img,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${dataItem.name}',
            style: TextStyle(fontSize: 32),
          ),
        ],
      ),
    );
  }
}
