import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/favourite_pokemons/favourite_pokemons_bloc.dart';
import 'package:pokemon_go/bloc/pokemon_store/pokemon_store_bloc.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/utilities.dart';
import 'package:pokemon_go/ui/widgets/stat_item.dart';

class PokeMonDetail extends StatefulWidget {
  final Pokemon pokemon;

  const PokeMonDetail({Key? key, required this.pokemon}) : super(key: key);

  @override
  _PokeMonDetailState createState() => _PokeMonDetailState();
}

class _PokeMonDetailState extends State<PokeMonDetail> {
  late PokemonDetailResponse pokeMonDetail;
  late String types;

  late num averagePower;

  late Color bgColor;

  late FavouritePokemonsBloc _favouritePokemonsBloc;

  late PokemonStoreBloc _checkPokemon ;


  @override
  void initState() {
    pokeMonDetail = widget.pokemon.pokemonDetails;
    types = widget.pokemon.types;
    averagePower = widget.pokemon.averagePower;
    bgColor = widget.pokemon.bgColor;
    _checkPokemon = PokemonStoreBloc();
    _favouritePokemonsBloc = BlocProvider.of<FavouritePokemonsBloc>(context);
    _checkPokemon.add(CheckFavouritePokemon(pokeMonDetail.id.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          BlocConsumer(
        bloc: _checkPokemon,
        listener: (context, state) {
          if(state is SaveFavouritePokemonsSuccessful){
           _favouritePokemonsBloc.add(const FetchFavouritePokemon());
          }
          if(state is RemoveFavouritePokemon){
            _favouritePokemonsBloc.add(const FetchFavouritePokemon());
          }
          if(state is CheckFavouritePokemonsSuccessful){
            _favouritePokemonsBloc.add(const FetchFavouritePokemon());
          }
        },
        builder: (context, state) {
          if (state is CheckFavouritePokemonsSuccessful) {
            return !state.pokemonExist
                ? GestureDetector(
                    onTap: () {
                      _checkPokemon
                          .add(SaveFavouritePokemon(widget.pokemon));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: ceruleanBlue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Text('Mark as favourite',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      _checkPokemon
                          .add(RemoveFavouritePokemon(widget.pokemon.pokemonDetails.id.toString()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: periwinklePurple,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: const Text('Remove from favourites',
                          style: TextStyle(
                              color: ceruleanBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  );
          }
          return const SizedBox();
        },
      ),
      appBar: AppBar(
        backgroundColor: bgColor.withOpacity(0.2),
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: bgColor.withOpacity(0.2),
                image: DecorationImage(
                    image: const AssetImage(
                      'assets/pokemon_bg.png',
                    ),
                    alignment: Alignment.centerRight,
                    colorFilter: ColorFilter.mode(
                        bgColor.withOpacity(0.4), BlendMode.srcATop))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pokeMonDetail.name!.toCapitalize(),
                  style: const TextStyle(
                      color: mirageBlue,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  types,
                  style: const TextStyle(
                      color: mirageBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#00${pokeMonDetail.id}',
                        style: const TextStyle(
                            color: mirageBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Hero(
                        tag: pokeMonDetail.id.toString(),
                        child: CachedNetworkImage(
                          imageUrl: pokeMonDetail
                              .sprites!.other.officialArtwork.frontDefault,
                          height: 140,
                          //alignment: Alignment.center,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              strokeWidth: 2,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  ceruleanBlue),
                              backgroundColor: doveGrey,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Height',
                      style: TextStyle(
                          color: doveGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${pokeMonDetail.height}',
                      style: const TextStyle(
                          color: mirageBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weight',
                      style: TextStyle(
                          color: doveGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${pokeMonDetail.weight}',
                      style: const TextStyle(
                          color: mirageBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BMI',
                      style: TextStyle(
                          color: doveGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.pokemon.bmi,
                      style: const TextStyle(
                          color: mirageBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Divider(
            color: doveGrey.withOpacity(0.1),
            thickness: 7,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 12),
            child: Text(
              'Base stats',
              style: TextStyle(
                  color: mirageBlue, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: doveGrey.withOpacity(0.1),
            thickness: 1,
          ),
          StatsItem(
            score: pokeMonDetail.stats![0].baseStat,
            title: 'HP',
            progressColor: cerisePink,
          ),
          StatsItem(
            score: pokeMonDetail.stats![1].baseStat,
            title: 'Attack',
            progressColor: cerisePink,
          ),
          StatsItem(
            score: pokeMonDetail.stats![2].baseStat,
            title: 'Defense',
            progressColor: cerisePink,
          ),
          StatsItem(
            score: pokeMonDetail.stats![3].baseStat,
            title: 'Special Attack',
            progressColor: goldTipsYellow,
          ),
          StatsItem(
            score: pokeMonDetail.stats![4].baseStat,
            title: 'Special Defense',
            progressColor: goldTipsYellow,
          ),
          StatsItem(
            score: pokeMonDetail.stats![5].baseStat,
            title: 'Speed',
            progressColor: cerisePink,
          ),
          StatsItem(
            score: widget.pokemon.averagePower,
            title: 'Avg. Power',
            progressColor: cerisePink,
          ),
        ],
      ),
    );
  }
}
