import 'package:flutter/material.dart';
import 'package:seccion6_componentes/src/models/pelicula_model.dart';
class MovieHorizontal extends StatelessWidget {


  final List<Pelicula> peliculas;

  final Function siguientePagina;

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );



  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {


    final _screenSize = MediaQuery.of(context).size;

    

    
    _pageController.addListener(() {

      if(_pageController.position.pixels >= (_pageController.position.maxScrollExtent-200)){
       
        siguientePagina();

      }
      
    });



    return Container(
      height: _screenSize.height*0.25,
      child:PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemBuilder: (BuildContext context, int i){
          return _tarjeta(context,peliculas[i]);
        },
        itemCount: peliculas.length,
      ),

      // child: ListView.builder(
      //   itemBuilder: (BuildContext contex,int index){
      //     return _tarjetas()[index];

      //   },
      //   scrollDirection:Axis.horizontal,
      //   itemCount: _tarjetas().length,
      //   )
    );
  }

  Widget _tarjeta(BuildContext context,Pelicula pelicula){
    return Container(
        margin: EdgeInsets.only(right: 15.0),
        child:  Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPoster()),
                fit:BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        )
      );
 

  }

  // List<Widget> _tarjetas(context) {

  //   return peliculas.map((pelicula){
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child:  Column(
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.0),
  //             child: FadeInImage(
  //               placeholder: AssetImage('assets/img/no-image.jpg'), 
  //               image: NetworkImage(pelicula.getPoster()),
  //               fit:BoxFit.cover,
  //               height: 160.0,
  //             ),
  //           ),
  //           SizedBox(height: 5.0,),
  //           Text(
  //             pelicula.title, 
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       )
  //     );
  //   }).toList();

  // }
}