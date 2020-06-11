import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  String seleccion = "";
  final peliculasProvider = new PeliculasProviders();
  final peliculitas = ["solo 100", "la ultima noche", "la liga de la justicia"];

  final peliculasRecientes = ["spiderman", "capitan America"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
    //   throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
    //  throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //  throw UnimplementedError();

    return Center(
      child: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.green,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;

            return ListView(
                children: peliculas
                    .map((pelicula) => ListTile(
                          leading: FadeInImage(
                              placeholder: AssetImage("assets/img/no-image.jpg"),
                              image: NetworkImage(pelicula.getPosterImage(),
                              
                              ),
                              fit: BoxFit.contain,
                              ),
                              title: Text(pelicula.title),
                              subtitle: Text(pelicula.originalTitle),
                              onTap: (){
                                close(context, null);
                                pelicula.uniqueId = '';
                                Navigator.pushNamed(context, "detalle", arguments: pelicula);
                              },
                        ),

                        )
                    .toList());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // TODO: implement buildSuggestions
  //   //throw UnimplementedError();
  //   final listaSugerida = (query.isEmpty)
  //       ? peliculasRecientes
  //       : peliculitas
  //           .where((element) => element.toLowerCase().startsWith(query))
  //           .toList();
  //   return ListView.builder(
  //     itemBuilder: (context, int i) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listaSugerida[i]),
  //         onTap: () {
  //           seleccion = listaSugerida[1];

  //           showResults(context);
  //         },
  //       );
  //     },
  //     itemCount: listaSugerida.length,
  //   );
  // }
}
