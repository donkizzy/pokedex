import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_state.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/repository/pokemon_repository.dart';
import 'package:pokemon_go/shared/utilities.dart';

class FetchPokemonBloc extends Cubit<FetchPokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepository();

  FetchPokemonBloc() : super(FetchPokemonInitial());

  void fetchNextPokeMon() async {
    try {
      emit(FetchPokemonNextPageLoading());
      var response = await _pokemonRepository.fetchPokemonNextList();
      List<Pokemon> pokemonList = <Pokemon>[];

      if (response.last.status) {
        //loop through the list to modify the data
        for (var e in response) {
          //loop through the stats object and sum up the stats so that the average power can be easily gotten
          var statArray =
              e.stats!.map((e) => e.baseStat).reduce((a, b) => a + b);

          //loop through the types object to get the types data and concatenate it
          var typesArray = e.types!.map((e) => e.type.name.toCapitalize());

          // loop through to get the dominant color in an image
          PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
            NetworkImage(e.sprites!.other.officialArtwork.frontDefault),
          );

          //calculate the average power and bmi
          var bmi = (e.weight! / (e.height! * e.height!)).toStringAsFixed(2);
          var averagePower = double.parse((statArray / 6).toStringAsFixed(2));

          var pokemon = Pokemon(
              types: typesArray.join(','),
              averagePower: averagePower,
              bgColor: palette.dominantColor!.color,
              pokemonDetails: e,
              bmi: bmi);
          pokemonList.add(pokemon);
        }

        emit(FetchPokemonSuccessful(pokemonList));
      } else {
        emit(FetchPokemonError(response.last.message));
      }
    } catch (e) {
      emit(FetchPokemonError(e.toString()));
    }
  }

  Future<void> fetchPokeMon(Emitter<FetchPokemonState> emit) async {
    try {
      emit(FetchPokemonLoading());

      var response = await _pokemonRepository.fetchPokemonList();
      List<Pokemon> pokemonList = <Pokemon>[];

      if (response.last.status) {
        //loop through the list to modify the data
        for (var e in response) {
          //loop through the stats object and sum up the stats so that the average power can be easily gotten
          int statSum = e.stats!.map((e) => e.baseStat).reduce((a, b) => a + b);

          //loop through the types object to get the types data and concatenate it
          List<String> typesList =
              e.types!.map((e) => e.type.name.toCapitalize()).toList();

          // loop through to get the dominant color in an image
          PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
            NetworkImage(e.sprites!.other.officialArtwork.frontDefault),
          );

          //calculate the average power and bmi
          var bmi = (e.weight! / (e.height! * e.height!)).toStringAsFixed(2);
          var averagePower = double.parse((statSum / 6).toStringAsFixed(2));

          var pokemon = Pokemon(
              types: typesList.join(','),
              averagePower: averagePower,
              bgColor: palette.dominantColor!.color,
              pokemonDetails: e,
              bmi: bmi);
          pokemonList.add(pokemon);
        }

        emit(FetchPokemonSuccessful(pokemonList));
      } else {
        emit(FetchPokemonError(response.last.message));
      }
    } catch (e) {
      emit(FetchPokemonError(e.toString()));
    }
  }
}
