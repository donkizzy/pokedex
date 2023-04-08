import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_state.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/network/api_error.dart';
import 'package:pokemon_go/repository/pokemon_repository.dart';
import 'package:pokemon_go/repository/pokemon_repository_impl.dart';
import 'package:pokemon_go/shared/utilities.dart';


class FetchPokemonBloc extends Cubit<FetchPokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepositoryImpl();

  FetchPokemonBloc() : super(FetchPokemonInitial());

  void fetchNextPokeMon() async {
    try {
      emit(FetchPokemonNextPageLoading());
      List<Pokemon> pokemonList = <Pokemon>[];
      Either<ApiError, List<PokemonDetailResponse>> response = await _pokemonRepository.fetchPokemonNextList();
      response.fold((l) =>  emit(FetchPokemonError(l.errorDescription)), (pokeMons) async {
        //loop through the list to modify the data
        for (var e in pokeMons) {
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
      });

    } catch (e) {
      emit(FetchPokemonError(e.toString()));
    }
  }

  Future<void> fetchPokeMon() async {
    try {
      emit(FetchPokemonLoading());

      Either<ApiError, List<PokemonDetailResponse>> pokemonResponse = await _pokemonRepository.fetchPokemonList();
      List<Pokemon> pokemonList = <Pokemon>[];
      pokemonResponse.fold((l) {
        emit(FetchPokemonError(l.errorDescription));
      }, (pokeMons) async {
        //loop through the list to modify the data
        for (var e in pokeMons) {
          //loop through the stats object and sum up the stats so that the average power can be easily gotten
          int statSum = e.stats!.map((e) => e.baseStat).reduce((a, b) => a + b);

          //loop through the types object to get the types data and concatenate it
          List<String>? typesList = e.types?.map((e) => e.type.name.toCapitalize()).toList();

          // loop through to get the dominant color in an image
          PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
            NetworkImage(e.sprites!.other.officialArtwork.frontDefault),
          );

          //calculate the average power and bmi
          var bmi = (e.weight! / (e.height! * e.height!)).toStringAsFixed(2);
          var averagePower = double.parse((statSum / 6).toStringAsFixed(2));

          var pokemon = Pokemon(
              types: typesList?.join(',') ?? '',
              averagePower: averagePower,
              bgColor: palette.dominantColor!.color,
              pokemonDetails: e,
              bmi: bmi);
          pokemonList.add(pokemon);
        }
        emit(FetchPokemonSuccessful(pokemonList));
      });



    } catch (e) {
      emit(FetchPokemonError(e.toString()));
    }
  }
}
