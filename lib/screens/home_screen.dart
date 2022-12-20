import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/playing_movie_bloc.dart';
import 'package:movie_app/blocs/playing_movie_event.dart';
import 'package:movie_app/blocs/playing_movie_state.dart';
import 'package:movie_app/screens/favorites_screen.dart';

import '../models/movie_model.dart';
import '../widgets/card_movie_widget.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  List<MovieModel> movieList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PlayingMovieBloc>().add(GetPlayingMovieEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('${user.photoURL}'),
                        ),
                        const SizedBox(height: 10),
                        Text('${user.displayName}'),
                        const SizedBox(height: 4),
                        Text('${user.email}'),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('Movies'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Favorites'),
                onTap: () {
                  Navigator.pushNamed(context, FavoriteScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BlocBuilder<PlayingMovieBloc, PlayingMovieState>(
        builder: (context, state) {
          if (state is PlayingMovieLoadingState && movieList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PlayingMovieHasDataState) {
            movieList.addAll(state.movieList);
          }
          if (state is PlayingMovieErrorState) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return CardMovieWidget(movieList[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: movieList.length,
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
