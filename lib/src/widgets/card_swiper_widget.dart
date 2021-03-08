import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:seccion6_componentes/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

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

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag:peliculas[index].uniqueId,
            child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: (){

                        //print(pelicula.title);
                        Navigator.pushNamed(context, 'detalle',arguments: peliculas[index]);
                          
                      },
                      child: FadeInImage(
                        placeholder: AssetImage('assets/img/no-image.jpg'), 
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          peliculas[index].getPoster()
                        )
                      ),
                    )
                  ),
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
