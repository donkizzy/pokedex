



import 'package:equatable/equatable.dart';

abstract class FetchPokemonEvent extends Equatable {

  const FetchPokemonEvent() ;

  // @override
  // List<Object> get props => [];
}

class FetchPokemon extends FetchPokemonEvent {


  const FetchPokemon();

  @override
  List<Object?> get props => [];

}