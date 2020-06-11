import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSwiperWidget({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 2.0),
      child: new Swiper(
        itemHeight: _screeSize.height * 0.5,
        itemWidth: _screeSize.width * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = "${peliculas[index].id}-tarjeta";
          print(peliculas[index].uniqueId);
          return
          //  Hero(
          //   tag: peliculas[index].uniqueId,
          //   child: 
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImage()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
                );
       //   );
        },
        itemCount: 3,
        layout: SwiperLayout.STACK,

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
