import 'package:flutter/material.dart';
import 'package:seccion6_componentes/src/providers/peliculas_provider.dart';
import 'package:seccion6_componentes/src/search/search_delegate.dart';
import 'package:seccion6_componentes/src/widgets/card_swiper_widget.dart';
import 'package:seccion6_componentes/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  
  final peliculasProvider = new PeliculasProvider();
  

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas en cines"),
          backgroundColor: Colors.indigoAccent,
          actions: [IconButton(icon: Icon(Icons.search), onPressed: () {

            showSearch(
              context: context, 
              delegate: DataSearch(),
              //query: "hola"
            );

          })],
        ),
        resizeToAvoidBottomInset: false, //algo que ver con el teclado :v 
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
            height: 400.0//MediaQuery.of(context).size.height *0.40, //deberia ser global reemplazar 400.0
            //padding: EdgeInsets.only(top: 10.0), //borrar
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(padding: EdgeInsets.only(left: 20.0), child: Text('Populares', style: Theme.of(context).textTheme.subtitle1 ,)),
          
          SizedBox(height:5.0 ,),
          
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                  );
              }else{
                return  Center(child: CircularProgressIndicator());
              }
              
            },
          ),

        ],
      )
    );
  }
}
