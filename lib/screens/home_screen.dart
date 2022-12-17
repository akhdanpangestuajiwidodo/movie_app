import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/playing_movie_bloc.dart';
import 'package:movie_app/blocs/playing_movie_state.dart';
import 'package:movie_app/screens/favorites_screen.dart';

import '../widgets/card_movie_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Movie App'),
              accountEmail: Text('akhdan'),
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
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BlocBuilder<PlayingMovieBloc, PlayingMovieState>(
        builder: (context, state) {
          if (state is PlayingMovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PlayingMovieHasDataState) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return CardMovieWidget(state.movieList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: state.movieList.length,
            );
          }
          if (state is PlayingMovieErrorState) {
            return Center(
              child: Text(state.message.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
