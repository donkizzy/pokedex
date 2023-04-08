import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/models/pokemon_response.dart';
import 'package:pokemon_go/network/api_error.dart';
import 'package:pokemon_go/network/network_provider.dart';
import 'package:pokemon_go/repository/pokemon_repository.dart';


class PokemonRepositoryImpl extends PokemonRepository {

  final NetworkProvider _networkProvider = NetworkProvider();

  @override
  Future<Either<ApiError, List<PokemonDetailResponse>>> fetchPokemonList() async{
    List<PokemonDetailResponse> pokemonDetailList = <PokemonDetailResponse>[] ;
    try{
      const String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=20';

      var response = await _networkProvider.call(path: baseUrl, method: RequestMethod.get);

      if(response!.statusCode == 200){

        var box = Hive.box('nextUrl');

        PokemonResponse?  pokemonResponse = PokemonResponse.fromJson(response.data);
        pokemonResponse.status = true ;

        box.put('url', pokemonResponse.next);

        for (var result in pokemonResponse.results!) {
          var pokemon = await fetchPokemonDetail(result.url);
          pokemon.fold((l) => Left(ApiError(errorDescription:l.errorDescription)), (r) => pokemonDetailList.add(r));

        }
      }
      return Right(pokemonDetailList) ;
    }on DioError catch(e){
      pokemonDetailList.last = PokemonDetailResponse(message: e.message, status: false) ;
      return Left(ApiError(errorDescription: e.message));
    }

  }

  @override
  Future<Either<ApiError, List<PokemonDetailResponse>>> fetchPokemonNextList() async{
    List<PokemonDetailResponse> pokemonDetailList = <PokemonDetailResponse>[] ;
    try{
      var box = Hive.box('nextUrl');
      var url = box.get('url');

      var response = await _networkProvider.call(path: url, method: RequestMethod.get);
      if(response!.statusCode == 200){

        var box = Hive.box('nextUrl');

        PokemonResponse?  pokemonResponse = PokemonResponse.fromJson(response.data);
        pokemonResponse.status = true ;

        box.put('url', pokemonResponse.next);
        for (var result in pokemonResponse.results!) {
          var pokemon = await fetchPokemonDetail(result.url);
          pokemon.fold((l) => Left(ApiError(errorDescription:l.errorDescription)), (r) => pokemonDetailList.add(r));
        }

      }
      return Right(pokemonDetailList) ;
    }on DioError catch(e){
      pokemonDetailList.last = PokemonDetailResponse(message: e.message, status: false) ;
      return Left(ApiError(errorDescription: e.message));
    }
  }

  @override
  Future<Either<ApiError, PokemonDetailResponse>> fetchPokemonDetail(String url) async{
    late PokemonDetailResponse pokemonResponse ;
    try{
      var response = await _networkProvider.call(path: url, method: RequestMethod.get);

      if(response!.statusCode == 200){
        pokemonResponse = PokemonDetailResponse.fromJson(response.data);
        pokemonResponse.status = true ;
      }
      return Right(pokemonResponse) ;
    }on DioError catch(e){
      pokemonResponse = PokemonDetailResponse(message: e.message, status: false) ;
      return Left(ApiError(errorDescription: e.message));
    }

  }
}