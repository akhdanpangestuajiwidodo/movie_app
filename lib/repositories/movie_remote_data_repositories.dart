import 'dart:convert';

import 'package:movie_app/interfaces/movie_remote_data_interface.dart';
import 'package:movie_app/models/detail_movie_model.dart';
import 'package:movie_app/models/genre_detail_movie_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:http/http.dart' as http;

import '../models/movie_response_model.dart';

class MovieRemoteDataRepositories implements MovieRemoteDataInterface {
  static const API_KEY = 'api_key=be7ddc7074fe58edbe5eb7645a53072d';
  static const BASE_URL = 'https://api.themoviedb.org/3/movie';

  @override
  Future<List<MovieModel>?> getNowPlayingMovies(int page) async {
    final result = await http.get(Uri.parse('$BASE_URL/now_playing?$API_KEY&page=$page'));
    if (result.statusCode == 200) {
      return MovieResponseModel.fromJson(jsonDecode(result.body)).movieList;
    }else{
      return null;
    }
  }

  @override
  Future<DetailMovieModel?> getDetailMovie(int id) async{
    final result = await http.get(Uri.parse('$BASE_URL/$id?$API_KEY'));
    if(result.statusCode == 200){
      return DetailMovieModel .fromJson(jsonDecode(result.body));
    }else{
      return null;
    }
  }
}
