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

class FavouritePokemonsSaveSuccessful extends FavouritePokemonsState {

  final Pokemon pokemon ;

  const FavouritePokemonsSaveSuccessful(this.pokemon) ;
  @override
  List<Object> get props => [pokemon];
}

class SaveFavouritePokemonsLoading extends FavouritePokemonsState {
  @override
  List<Object> get props => [];
}

class SaveFavouritePokemonsSuccessful extends FavouritePokemonsState {
  @override
  List<Object> get props => [];
}

class CheckFavouritePokemonsSuccessful extends FavouritePokemonsState {
  final bool pokemonExist ;

 const CheckFavouritePokemonsSuccessful(this.pokemonExist);
  @override
  List<Object> get props => [pokemonExist];
}

class RemoveFavouritePokemonsSuccessful extends FavouritePokemonsState {

 const RemoveFavouritePokemonsSuccessful();
  @override
  List<Object> get props => [];
}

class FavouritePokemonsError extends FavouritePokemonsState {

  final String? error;

  const FavouritePokemonsError(this.error);

  @override
  List<Object?> get props => [error];
}
