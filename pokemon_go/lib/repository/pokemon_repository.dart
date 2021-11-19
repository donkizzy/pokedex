

import 'package:dio/dio.dart';
import 'package:pokemon_go/models/pokemon_response.dart';
import 'package:pokemon_go/network/network_provider.dart';
import 'package:pokemon_go/network/network_routes.dart';

class PokemonRepository {

  final NetworkProvider _networkProvider = NetworkProvider();

  Future<PokemonResponse> fetchPokemonList(int offset) async{
   late PokemonResponse pokemonResponse ;
    try{
      var response = await _networkProvider.call(path: NetworkRoutes.deleteMessage(offset), method: RequestMethod.get);
      if(response!.statusCode == 200){
        pokemonResponse = PokemonResponse.fromJson(response.data);
        pokemonResponse.status = true ;
      }
    }on DioError catch(e){
      pokemonResponse = PokemonResponse(message: e.message, status: false) ;
    }

    return pokemonResponse ;
  }
}