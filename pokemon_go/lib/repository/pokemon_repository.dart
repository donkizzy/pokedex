import 'package:dartz/dartz.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/network/api_error.dart';


abstract class PokemonRepository {

  Future<Either<ApiError, List<PokemonDetailResponse>>> fetchPokemonList() ;

  Future<Either<ApiError, List<PokemonDetailResponse>>> fetchPokemonNextList() ;

  Future<Either<ApiError, PokemonDetailResponse>> fetchPokemonDetail(String url)  ;
}