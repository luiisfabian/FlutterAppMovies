import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';
import 'package:peliculas/src/search/data_search.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas en cine"),
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                 showSearch(context: context, delegate: DataSearch(),
                 //  query: "Palabra a buscar"
                   );
                },
                
                ),
        
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperTarjetas(),
              _footerPeliculasPopulares(context),
            ],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData != null) {
          return CardSwiperWidget(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    //   return CardSwiperWidget(peliculas: [1,2,3,4,5]);
  }

  Widget _footerPeliculasPopulares(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              "populares",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStrem,
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // print(snapshot.data);

              // snapshot.data?.forEach((p) => {print(p.title)});

              if (snapshot.hasData) {
                return MovieHorizontalWidget(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                Center(child: CircularProgressIndicator());
              }
              //   return Container();
            },
          ),
        ],
      ),
    );
  }
}
