import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/detail_movie_bloc.dart';
import 'package:movie_app/blocs/playing_movie_bloc.dart';
import 'package:movie_app/blocs/playing_movie_event.dart';
import 'package:movie_app/repositories/movie_remote_data_repositories.dart';
import 'package:movie_app/screens/detail_movie_screen.dart';
import 'package:movie_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlayingMovieBloc>(
            create: (BuildContext context) =>
                PlayingMovieBloc(MovieRemoteDataRepositories())..add(GetPlayingMovieEvent())),
        BlocProvider<DetailMovieBloc>(
            create: (BuildContext context) =>
            DetailMovieBloc(MovieRemoteDataRepositories())),
      ],
      child: MaterialApp(
        title: 'MovieApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: _router,
      ),
    );
  }

  Map<String, WidgetBuilder> get _router => {
        HomeScreen.routeName: (_) => const HomeScreen(),
        DetailMovieScreen.routeName: (context) => DetailMovieScreen(id: ModalRoute.of(context)?.settings.arguments as int),
      };
}
