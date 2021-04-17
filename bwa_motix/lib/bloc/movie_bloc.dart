import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_motix/models/models.dart';
import 'package:bwa_motix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  @override
  MovieState get initialState => MovieInitial();

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      List<Movie> movies = await MovieServices.getMovies(1);
      //  ambil film di page 1, ada 20 movies,
      // 10 di now playing, 10 di coming soon.
      //
      //
      yield MovieLoaded(movies: movies);
    }
  }
}
