import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProviders {
  String _apiKey = '0c6ad3c7b93bdd45bba3efd45b1b0aff';
  String _url = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  int _popularesPage = 1;

  List<Pelicula> _populares = new List();

  bool _cargando = false;

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStrem =>
      _popularesStreamController.stream;

  void disposeStrem() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lenguaje,
      'page': _popularesPage.toString()
    });

    final respuesta = await _procesarRespuesta(url);

    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando = false;

    return respuesta;
  }

  Future<List<Actor>> getCast(String peliId) async {


    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key': _apiKey,
      'language': _lenguaje,
    });

    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);


    final cast = new  Cast.fromJsonList(decodeData['cast']);

    return cast.actores;
  
  }


    Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lenguaje,
      'query': query,
    });

    final respuesta = await http.get(url);
    final decodeData = json.decode(respuesta.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }
}
