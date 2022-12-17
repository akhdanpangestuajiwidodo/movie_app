import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/favorites_movie_bloc.dart';
import 'package:movie_app/blocs/favorites_movie_event.dart';
import 'package:movie_app/blocs/favorites_movie_state.dart';
import 'package:movie_app/models/movie_table_model.dart';
import 'package:movie_app/screens/favorites_screen.dart';

class FavoriteButton extends StatefulWidget {
  final MovieTableModel movie;

  const FavoriteButton(this.movie);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesMovieBloc, FavoritesMovieState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            context
                .read<FavoritesMovieBloc>()
                .add(AddFavoritesMovieEvent(widget.movie));
            setState(() {
              isFavorite = !isFavorite;
            });
            Navigator.pushNamed(context, FavoriteScreen.routeName);
          },
        );
      },
    );
  }
}
