import 'package:flutter/material.dart';
import 'package:seccion6_componentes/src/providers/peliculas_provider.dart';
import 'package:seccion6_componentes/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas en cines"),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _swiperTarjetas(),
              _footer(context)
            ],
          ),
        )
    );
  }

  _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            height: MediaQuery.of(context).size.height *0.50, //deberia ser global reemplazar 400.0
            padding: EdgeInsets.only(top: 10.0), //borrar
          );
        }
      },
    );

    // peliculasProvider.getEnCines();

    // return CardSwiper(
    //   peliculas: [1,2,3,4,5]
    // );
  }

  _footer(BuildContext context) {

    
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text('Populares', style: Theme.of(context).textTheme.subtitle1 ,),
          FutureBuilder(
            future: peliculasProvider.getPopulares(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
              return Container() ;
            },
          ),

        ],
      )
    );
  }
}
