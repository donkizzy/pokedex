



import 'package:equatable/equatable.dart';

abstract class FetchPokemonEvent extends Equatable {

  const FetchPokemonEvent() ;

  // @override
  // List<Object> get props => [];
}

class FetchPokemon extends FetchPokemonEvent {
  final int? offset;

  const FetchPokemon({ this.offset});

  @override
  List<Object?> get props => [offset];

}