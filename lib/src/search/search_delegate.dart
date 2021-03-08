import 'package:flutter/material.dart';
import 'package:seccion6_componentes/src/models/pelicula_model.dart';
import 'package:seccion6_componentes/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  //DataSearch(): super(searchFieldLabel:'Buscar Peliculas');
  String get searchFieldLabel => 'Buscar...';

  String seleccion = '';

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];

  final peliculasProvider = new PeliculasProvider();



  @override
  List<Widget> buildActions(BuildContext context) {
    // actiones de nuestros appbars como: icono para limpiar el texto
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          print("clear");
          query='';
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        print("leading icons press");
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crear los resultados a mostrar
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe
    if ( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

          if( snapshot.hasData ) {
            
            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map( (pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                      image: NetworkImage( pelicula.getPoster() ),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text( pelicula.title ),
                    subtitle: Text( pelicula.originalTitle ),
                    onTap: (){
                      close( context, null);
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                    },
                  );
              }).toList()
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );


  }




}