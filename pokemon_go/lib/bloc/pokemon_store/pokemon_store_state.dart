part of 'pokemon_store_bloc.dart';

abstract class PokemonStoreState extends Equatable {
  const PokemonStoreState();
}

class PokemonStoreInitial extends PokemonStoreState {
  @override
  List<Object> get props => [];
}

class FavouritePokemonsLoading extends PokemonStoreState {
  @override
  List<Object> get props => [];
}

class FavouritePokemonsSaveSuccessful extends PokemonStoreState {

  final Pokemon pokemon ;

  const FavouritePokemonsSaveSuccessful(this.pokemon) ;
  @override
  List<Object> get props => [pokemon];
}

class SaveFavouritePokemonsLoading extends PokemonStoreState {
  @override
  List<Object> get props => [];
}

class SaveFavouritePokemonsSuccessful extends PokemonStoreState {
  @override
  List<Object> get props => [];
}

class CheckFavouritePokemonsSuccessful extends PokemonStoreState {
  final bool pokemonExist ;

  const CheckFavouritePokemonsSuccessful(this.pokemonExist);
  @override
  List<Object> get props => [pokemonExist];
}

class FavouritePokemonsError extends PokemonStoreState {

  final String? error;

  const FavouritePokemonsError(this.error);

  @override
  List<Object?> get props => [error];
}

