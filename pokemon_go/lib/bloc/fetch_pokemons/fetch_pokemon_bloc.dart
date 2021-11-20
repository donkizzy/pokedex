import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_event.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_state.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_go/repository/pokemon_repository.dart';
import 'package:pokemon_go/shared/utilities.dart';

class FetchPokemonBloc extends Bloc<FetchPokemonEvent, FetchPokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepository();

  FetchPokemonBloc() : super( FetchPokemonInitial()) {
    on<FetchPokemonEvent>((event, emit) async {
      if (event is FetchPokemon) {
        try {
          emit(FetchPokemonLoading());
          var response = await _pokemonRepository.fetchPokemonList(offset:  const FetchPokemon().offset);

          if (response.last.status) {

            List<String> types = <String>[] ;
            List<int> stats = <int>[] ;
            List<Color> bgColor = <Color>[];

            //loop through the list to modify the data
            for (var e in response) {

              //loop through the stats object and sum up the stats so that the average power can be easily gotten
              var statArray = e.stats!.map((e) => e.baseStat).reduce((a, b) => a + b);

              //loop through the types object to get the types data and concatenate it
              var typesArray = e.types!.map((e) => e.type.name.toCapitalize());

             // loop through to get the dominant color in an image
              PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
                  NetworkImage(e.sprites!.other.officialArtwork.frontDefault),
              );
              palette.dominantColor ;

              //add items to the list
              types.add(typesArray.join(','));
              stats.add(statArray);
              bgColor.add(palette.dominantColor!.color);

            }

            emit(FetchPokemonSuccessful(response,types,stats,bgColor));

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
