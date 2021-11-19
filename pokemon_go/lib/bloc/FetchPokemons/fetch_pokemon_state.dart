

import 'package:equatable/equatable.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';



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
  final List<PokemonDetailResponse>  pokemonDetails;

  const FetchPokemonSuccessful(this.pokemonDetails);

  @override
  List<Object> get props => [pokemonDetails];
}

class FetchPokemonError extends FetchPokemonState {
  final String? error;

  const FetchPokemonError(this.error);

  @override
  List<Object?> get props => [error];
}

