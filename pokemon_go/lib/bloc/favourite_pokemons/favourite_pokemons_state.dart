part of 'favourite_pokemons_bloc.dart';

abstract class FavouritePokemonsState extends Equatable {
  const FavouritePokemonsState();
}

class FavouritePokemonsInitial extends FavouritePokemonsState {
  @override
  List<Object> get props => [];
}

class FavouritePokemonsLoading extends FavouritePokemonsState {
  @override
  List<Object> get props => [];
}

class FavouritePokemonsFetchSuccessful extends FavouritePokemonsState {

  final List<Pokemon> pokemon ;

  const FavouritePokemonsFetchSuccessful(this.pokemon) ;

  @override
  List<Object> get props => [pokemon];
}

class FavouritePokemonsError extends FavouritePokemonsState {

  final String? error;

  const FavouritePokemonsError(this.error);

  @override
  List<Object?> get props => [error];
}
