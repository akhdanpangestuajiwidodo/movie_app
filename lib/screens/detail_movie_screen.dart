import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/detail_movie_bloc.dart';
import 'package:movie_app/blocs/detail_movie_event.dart';
import 'package:movie_app/blocs/detail_movie_state.dart';
import 'package:movie_app/models/genre_detail_movie_model.dart';
import 'package:movie_app/models/movie_table_model.dart';

import '../widgets/favorite_button_widget.dart';

class DetailMovieScreen extends StatefulWidget {
  static const routeName = 'detail_movie_screen';
  final int id;

  DetailMovieScreen({required this.id});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    context.read<DetailMovieBloc>().add(GetDetailMovieEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
          builder: (context, state) {
        if (state is DetailMovieLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is DetailMovieHasDataState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${state.movie.posterPath}',
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.fill,
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            FavoriteButton(
                              MovieTableModel(
                                  id: state.movie.id,
                                  title: state.movie.title,
                                  posterPath: state.movie.posterPath,
                                  overview: state.movie.overview,
                                  username: user.displayName!),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.movie.originalTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFFE8E8EA),
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${state.movie.voteAverage}',
                            style: const TextStyle(
                                color: Color(0xFF4D577F),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0,),
                Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    'Release: ${state.movie.releaseDate}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Color(0xFF4D577F),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 14.0),
                Container(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    state.movie.overview,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is DetailMovieErrorState) {
          return Center(
            child: Text(state.message.toString()),
          );
        }
        return Container();
      }),
    );
  }

  String _showGenres(List<GenreDetailMovieModel> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

}
