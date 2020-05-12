import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiperWidget extends StatelessWidget {
  final List<dynamic> peliculas;
  CardSwiperWidget({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        itemHeight: _screeSize.height * 0.5,
        itemWidth: _screeSize.width * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: new Image.network(
              "http://via.placeholder.com/350x150",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 3,
        layout: SwiperLayout.STACK,

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
