import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/favorites_movie_bloc.dart';
import 'package:movie_app/blocs/favorites_movie_event.dart';
import 'package:movie_app/blocs/favorites_movie_state.dart';
import 'package:movie_app/widgets/card_favorite_widget.dart';

class FavoriteScreen extends StatefulWidget {
  static const routeName = 'favorite_screen';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    context
        .read<FavoritesMovieBloc>()
        .add(GetFavoritesMovieEvent(user.displayName!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: BlocBuilder<FavoritesMovieBloc, FavoritesMovieState>(
        builder: (context, state) {
          if (state is GetFavoritesMovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetFavoritesMovieHasDataState) {
            return Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Hello, ${user.displayName} this is your movies',
                    style: const TextStyle(
                        color: Color(0xFFE8E8EA),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      return CardFavoriteWidget(state.movieList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: state.movieList.length,
                  ),
                ),
              ],
            );
          } else if (state is GetFavoritesMovieErrorState) {
            return Center(
              child: Text('${user.displayName}, ${state.message}'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
