part of 'favourite_pokemons_bloc.dart';

abstract class FavouritePokemonsEvent extends Equatable {
  const FavouritePokemonsEvent();
}

class FetchFavouritePokemon extends FavouritePokemonsEvent {

  const FetchFavouritePokemon();

  @override
  List<Object?> get props => [];

}

class SaveFavouritePokemon extends FavouritePokemonsEvent {

  final Pokemon pokemon ;
  const SaveFavouritePokemon(this.pokemon);

  @override
  List<Object?> get props => [pokemon];

}
