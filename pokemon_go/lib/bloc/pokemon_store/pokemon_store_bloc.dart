
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_go/models/pokemon.dart';

part 'pokemon_store_event.dart';
part 'pokemon_store_state.dart';

class PokemonStoreBloc extends Bloc<PokemonStoreEvent, PokemonStoreState> {
  PokemonStoreBloc() : super(PokemonStoreInitial()) {
    on<PokemonStoreEvent>((event, emit) {
      if (event is SaveFavouritePokemon){

        try{
          emit(SaveFavouritePokemonsLoading());

          var box = Hive.box('pokemonBox');

          box.put(event.pokemon.pokemonDetails.id.toString(), event.pokemon.toJson());

          emit(SaveFavouritePokemonsSuccessful());
          emit (const CheckFavouritePokemonsSuccessful(true)) ;

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
        emit(SaveFavouritePokemonsSuccessful());
        emit (const CheckFavouritePokemonsSuccessful(false)) ;
      }
    });
  }
}
