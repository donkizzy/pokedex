



import 'package:equatable/equatable.dart';

abstract class FetchPokemonEvent extends Equatable {

  const FetchPokemonEvent() ;
}

class FetchPokemon extends FetchPokemonEvent {


  const FetchPokemon();

  @override
  List<Object?> get props => [];

}


class FetchPokemonNextPage extends FetchPokemonEvent {


  const FetchPokemonNextPage();

  @override
  List<Object?> get props => [];

}