import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_go/models/pokemon.dart';

part 'favourite_pokemons_state.dart';

class FavouritePokemonsBloc extends Cubit<FavouritePokemonsState> {

  FavouritePokemonsBloc() : super(FavouritePokemonsInitial()) ;

  void fetchFavouritePokemon() async{
        try{
          emit(FavouritePokemonsLoading());

          var box = Hive.box('pokemonBox');

          Iterable<dynamic> allPokemon = box.values;

          Iterable<dynamic> pokemons = allPokemon.map((e) => Pokemon.fromJson(Map<String, dynamic>.from(e)));

          List<Pokemon> pokemonList =  List<Pokemon>.from(pokemons) ;

          emit(FavouritePokemonsFetchSuccessful(pokemonList));

        }catch(e){
          emit( FavouritePokemonsError(e.toString()));
        }
  }
}
