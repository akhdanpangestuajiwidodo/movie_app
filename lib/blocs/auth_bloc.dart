import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/auth_event.dart';
import 'package:movie_app/blocs/auth_state.dart';
import 'package:movie_app/repositories/auth_repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories _authRepositories;

  AuthBloc(this._authRepositories) : super(UnAuthenticatedState()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authRepositories.signIn(event.email, event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authRepositories.signUp(event.email, event.password, event.username);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _authRepositories.signInWithGoogle();
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      await _authRepositories.signOut();
      emit(UnAuthenticatedState());
    });
  }
}
