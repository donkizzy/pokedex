import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/FetchPokemons/fetch_pokemon_event.dart';
import 'package:pokemon_go/bloc/FetchPokemons/fetch_pokemon_state.dart';
import 'package:pokemon_go/repository/pokemon_repository.dart';

class FetchPokemonBloc extends Bloc<FetchPokemonEvent, FetchPokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepository();

  FetchPokemonBloc() : super(FetchPokemonInitial()) {
    on<FetchPokemonEvent>((event, emit) async {
      if (event is FetchPokemon) {
        try {
          emit(FetchPokemonLoading());

          var response = await _pokemonRepository.fetchPokemonList(offset:  const FetchPokemon().offset);

          if (response.last.status) {

            emit(FetchPokemonSuccessful(response));

          } else {

            emit(FetchPokemonError(response.last.message));

          }
        } catch (e) {
          emit(FetchPokemonError(e.toString()));
        }
      }
    });
  }
}
