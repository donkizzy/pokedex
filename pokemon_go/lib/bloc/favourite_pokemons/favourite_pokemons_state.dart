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
  final List<PokemonDetailResponse>  pokemonDetails;
  final List<String> types ;
  final List<int> averagePower ;
  final List<Color> bgColor ;

  const FavouritePokemonsFetchSuccessful(this.pokemonDetails, this.types, this.averagePower, this.bgColor) ;

  @override
  List<Object> get props => [pokemonDetails,types,averagePower];
}

class FavouritePokemonsSaveSuccessful extends FavouritePokemonsState {

  final PokemonDetailResponse  pokemonDetails;
  final List<String> types ;
  final List<int> averagePower ;
  final List<Color> bgColor ;

  const FavouritePokemonsSaveSuccessful(this.pokemonDetails, this.types, this.averagePower, this.bgColor) ;
  @override
  List<Object> get props => [];
}

class FavouritePokemonsError extends FavouritePokemonsState {

  final String? error;

  const FavouritePokemonsError(this.error);

  @override
  List<Object?> get props => [error];
}
