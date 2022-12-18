import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/detail_movie_bloc.dart';
import 'package:movie_app/blocs/detail_movie_event.dart';
import 'package:movie_app/blocs/detail_movie_state.dart';
import 'package:movie_app/models/movie_table_model.dart';
import 'package:movie_app/screens/home_screen.dart';

import '../widgets/favorite_button_widget.dart';

class DetailMovieScreen extends StatefulWidget {
  static const routeName = 'detail_movie_screen';
  final int id;

  DetailMovieScreen({required this.id});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
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
                              backgroundColor: Colors.grey,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, HomeScreen.routeName);
                                },
                              ),
                            ),
                            FavoriteButton(
                              MovieTableModel(
                                  id: state.movie.id,
                                  title: state.movie.title,
                                  posterPath: state.movie.posterPath,
                                  overview: state.movie.overview,
                                  username: "akhdan"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    state.movie.originalTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Staatliches',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.movie.overview,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Oxygen',
                    ),
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
}
