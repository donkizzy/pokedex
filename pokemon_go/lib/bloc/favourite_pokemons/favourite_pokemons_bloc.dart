
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_go/models/pokemon.dart';

part 'favourite_pokemons_event.dart';
part 'favourite_pokemons_state.dart';

class FavouritePokemonsBloc extends Bloc<FavouritePokemonsEvent, FavouritePokemonsState> {
  FavouritePokemonsBloc() : super(FavouritePokemonsInitial()) {
    on<FavouritePokemonsEvent>((event, emit)async {

      if (event is SaveFavouritePokemon){

       try{
         emit(SaveFavouritePokemonsLoading());

         var box = Hive.box('pokemonBox');

         box.put(event.pokemon.pokemonDetails.id.toString(), event.pokemon.toJson());

         emit(SaveFavouritePokemonsSuccessful());

       }catch(e){
         emit( FavouritePokemonsError(e.toString()));
       }
      }

      if (event is FetchFavouritePokemon){

        try{

          emit(FavouritePokemonsLoading());

          var box = Hive.box('pokemonBox');

          var allPokemon = box.values;

          var pokemons = allPokemon.map((e) => Pokemon.fromJson(Map<String, dynamic>.from(e)));

          List<Pokemon> pokemonList =  List<Pokemon>.from(pokemons) ;

          emit(FavouritePokemonsFetchSuccessful(pokemonList));

        }catch(e){
          emit( FavouritePokemonsError(e.toString()));
        }

      }

      if(event is CheckFavouritePokemon){
        var box = Hive.box('pokemonBox');
        var pokemonExist = box.get(event.id);
        if(pokemonExist == null){
          emit (const CheckFavouritePokemonsSuccessful(false));
        }else {
          emit (const CheckFavouritePokemonsSuccessful(true)) ;
        }
      }
      if(event is RemoveFavouritePokemon){
        var box = Hive.box('pokemonBox');
        box.delete(event.id);
        emit(const RemoveFavouritePokemonsSuccessful());
      }
    });
  }
}
