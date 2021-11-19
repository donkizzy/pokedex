


abstract class NetworkRoutes {

  static const String baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  static String fetchPokemon(int offset) => baseUrl  + '?offset=50&limit=20';

}