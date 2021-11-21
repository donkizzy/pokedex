

import 'package:equatable/equatable.dart';
import 'package:pokemon_go/models/pokemon.dart';



abstract class FetchPokemonState extends Equatable {
  const FetchPokemonState();
}

class FetchPokemonInitial extends FetchPokemonState {
  @override
  List<Object> get props => [];
}

class FetchPokemonLoading extends FetchPokemonState {
  @override
  List<Object> get props => [];
}

class FetchPokemonSuccessful extends FetchPokemonState {

  final List<Pokemon> pokemon ;

  const FetchPokemonSuccessful(this.pokemon);



  @override
  List<Object?> get props => [pokemon];

}

class FetchPokemonNextPageLoading extends FetchPokemonState {
  @override
  List<Object> get props => [];
}

class FetchPokemonNextPageSuccessful extends FetchPokemonState {

  final List<Pokemon> pokemon ;

  const FetchPokemonNextPageSuccessful(this.pokemon);



  @override
  List<Object?> get props => [pokemon];

}

class FetchPokemonError extends FetchPokemonState {
  final String? error;

  const FetchPokemonError(this.error);

  @override
  List<Object?> get props => [error];
}

