import 'package:flutter/material.dart';
import 'package:pokemon_app/models/poke_hub.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon;

  const DetailsScreen({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: Text('${pokemon.name}'),
        centerTitle: true,
      ),
      body: bodyWidget(context: context, poke: pokemon),
    );
  }
}

bodyWidget({BuildContext context, @required Pokemon poke}) {
  return Stack(
    children: [
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10,
        top: MediaQuery.of(context).size.height * 0.17,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                poke.name,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Height: ${poke.height}'),
              Text('Weight: ${poke.weight}'),
              Text('Type'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (poke.type != null)
                    for (var t in poke.type)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.orange),
                        child: Text(
                          '${t.toString().split('.').last}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
              Text('Weaknesses'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (poke.weaknesses != null)
                    for (var w in poke.weaknesses)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.redAccent),
                        child: Text(
                          '${w.toString().split('.').last}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
              Text('Next Evolution'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (poke.nextEvolution != null)
                    for (var e in poke.nextEvolution)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green),
                        child: Text(
                          '${e.name}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: poke.name,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: 280.0,
                width: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(poke.img), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
