

import 'package:dio/dio.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/models/pokemon_response.dart';
import 'package:pokemon_go/network/network_provider.dart';


class PokemonRepository {

  final NetworkProvider _networkProvider = NetworkProvider();

  Future<List<PokemonDetailResponse>> fetchPokemonList({int? offset}) async{
    List<PokemonDetailResponse> pokemonDetailList = <PokemonDetailResponse>[] ;
    try{
       const String baseUrl = 'https://pokeapi.co/api/v2/pokemon?limit=20';

      var response = await _networkProvider.call(path: baseUrl, method: RequestMethod.get);

      if(response!.statusCode == 200){

        PokemonResponse?  pokemonResponse = PokemonResponse.fromJson(response.data);
        pokemonResponse.status = true ;

        for (var result in pokemonResponse.results!) {
         var pokemon = await fetchPokemonDetail(result.url);
         pokemonDetailList.add(pokemon);
        }

      }
    }on DioError catch(e){
      pokemonDetailList.last = PokemonDetailResponse(message: e.message, status: false) ;
    }

    return pokemonDetailList ;
  }


  Future<PokemonDetailResponse> fetchPokemonDetail(String url) async{
   late PokemonDetailResponse pokemonResponse ;
    try{
      var response = await _networkProvider.call(path: url, method: RequestMethod.get);

      if(response!.statusCode == 200){
        pokemonResponse = PokemonDetailResponse.fromJson(response.data);
        pokemonResponse.status = true ;
      }
    }on DioError catch(e){
      pokemonResponse = PokemonDetailResponse(message: e.message, status: false) ;
    }

    return pokemonResponse ;
  }
}