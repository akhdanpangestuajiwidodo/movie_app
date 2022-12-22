import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/auth_event.dart';
import 'package:movie_app/blocs/auth_state.dart';
import 'package:movie_app/blocs/playing_movie_bloc.dart';
import 'package:movie_app/blocs/playing_movie_event.dart';
import 'package:movie_app/blocs/playing_movie_state.dart';
import 'package:movie_app/screens/favorites_screen.dart';
import 'package:movie_app/screens/sign_in_screen.dart';

import '../blocs/auth_bloc.dart';
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
      drawer: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticatedState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SignInScreen()),
              (route) => false,
            );
          }
        },
        child: Drawer(
          backgroundColor: const Color(0xFF1F233F),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.indigo,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '${user.displayName}',
                            style: const TextStyle(
                                color: Color(0xFFE8E8EA),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${user.email}',
                            style: const TextStyle(
                                color: Color(0xFFE8E8EA),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.movie,
                    color: Color(0xFFE8E8EA),
                  ),
                  title: const Text(
                    'Movies',
                    style: TextStyle(
                        color: Color(0xFFE8E8EA), fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.save,
                    color: Color(0xFFE8E8EA),
                  ),
                  title: const Text(
                    'Favorites',
                    style: TextStyle(
                        color: Color(0xFFE8E8EA), fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, FavoriteScreen.routeName);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Color(0xFFE8E8EA),
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Color(0xFFE8E8EA), fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                ),
              ],
            ),
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
