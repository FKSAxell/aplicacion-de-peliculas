import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //width: double.infinity,
      //height: _screenSize.height*0.25,

      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network('https://via.placeholder.com/250x150',fit: BoxFit.cover)
                );
        },
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.70,
        itemHeight: _screenSize.height * 0.50,
        layout: SwiperLayout.STACK,
        //autoplay: true,
      ),
    );
  }
}
//1865f43a0549ca50d341dd9ab8b29f49
