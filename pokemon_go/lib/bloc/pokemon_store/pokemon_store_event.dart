part of 'pokemon_store_bloc.dart';

abstract class PokemonStoreEvent extends Equatable {
  const PokemonStoreEvent();
}

class SaveFavouritePokemon extends PokemonStoreEvent {

  final Pokemon pokemon ;
  const SaveFavouritePokemon(this.pokemon);

  @override
  List<Object?> get props => [pokemon];

}

class RemoveFavouritePokemon extends PokemonStoreEvent {

  final String id ;
  const RemoveFavouritePokemon(this.id);

  @override
  List<Object?> get props => [id];

}

class CheckFavouritePokemon extends PokemonStoreEvent {

  final String id ;
  const CheckFavouritePokemon(this.id
      );

  @override
  List<Object?> get props => [id];

}

