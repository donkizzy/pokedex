import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/favourite_pokemons/favourite_pokemons_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_state.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/widgets/all_pokemon.dart';
import 'package:pokemon_go/ui/widgets/pokemon_item.dart';
import 'package:pokemon_go/ui/widgets/pokemon_loader.dart';
import 'package:pokemon_go/ui/widgets/rectangle_tab_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late FetchPokemonBloc _fetchPokemonBloc;

  late FavouritePokemonsBloc _favouritePokemonsBloc;

  List<Pokemon> pokemonList = <Pokemon>[];
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
   ValueNotifier<int> favouriteCounter = ValueNotifier<int>(0);

  @override
  void initState() {
    _fetchPokemonBloc = FetchPokemonBloc();
    _favouritePokemonsBloc = BlocProvider.of<FavouritePokemonsBloc>(context);
    _favouritePokemonsBloc.fetchFavouritePokemon();
    _fetchPokemonBloc.fetchPokeMon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                pinned: true,
                centerTitle: true,
                title: Image.asset(
                  'assets/logo.png',
                  height: 33,
                ),
                bottom: TabBar(
                  labelColor: mirageBlue,
                  unselectedLabelColor: doveGrey,
                  indicator: const CurvedRectangleIndicator(
                    indicatorHeight: 4.0,
                    indicatorColor: ceruleanBlue,
                  ),
                  tabs: [
                    const Tab(
                      child: Text(
                        'All Pokemons',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Favourites',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            width: 5,
                          ),
                          ValueListenableBuilder(
                            valueListenable: favouriteCounter,
                            builder: (BuildContext context, int value, Widget? child) {
                              return value > 0 ? Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ceruleanBlue,
                                ),
                                child:  Center(
                                  child: Text('$value',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ) : const SizedBox();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              BlocConsumer(
                bloc: _fetchPokemonBloc,
                builder: (BuildContext context, state) {
                  if (state is FetchPokemonLoading) {
                    return const PokemonLoader();
                  }
                  if (state is FetchPokemonSuccessful) {
                    return AllPokemon(
                        fetchPokemonBloc: _fetchPokemonBloc,
                        pokemonList: pokemonList,
                        isLoading: isLoading);
                  }
                  if (state is FetchPokemonError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('${state.error}')),
                        MaterialButton(
                          onPressed: () {
                            _fetchPokemonBloc.fetchPokeMon();
                          },
                          color: ceruleanBlue,
                          textColor: Colors.white,
                          child: const Text('Retry'),
                        )
                      ],
                    );
                  }

                  return pokemonList.isNotEmpty
                      ? AllPokemon(
                          fetchPokemonBloc: _fetchPokemonBloc,
                          pokemonList: pokemonList,
                          isLoading: isLoading)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        );
                },
                listener: (BuildContext context, Object? state) {
                  if (state is FetchPokemonSuccessful) {
                    pokemonList.addAll(state.pokemon);
                    isLoading.value = false;
                  }
                  if (state is FetchPokemonNextPageLoading) {
                    isLoading.value = true;
                  }
                },
              ),
              BlocConsumer(
                bloc: _favouritePokemonsBloc,
                builder: (BuildContext context, state) {
                  if (state is FavouritePokemonsLoading) {
                    return const PokemonLoader();
                  }

                  if (state is FavouritePokemonsFetchSuccessful) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: mecuryGrey,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(12),
                        itemCount: state.pokemon.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio:
                              0.6,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return PokemonItem(
                            key: UniqueKey(),
                            pokemon: state.pokemon[index],
                          );
                        },
                      ),
                    );
                  }

                  if (state is FetchPokemonError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('${state.error}')),
                        MaterialButton(
                          onPressed: () {
                            _favouritePokemonsBloc.fetchFavouritePokemon();
                          },
                          color: ceruleanBlue,
                          textColor: Colors.white,
                          child: const Text('Retry'),
                        )
                      ],
                    );
                  }

                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
                listener: (BuildContext context, Object? state) {
                  if(state is FavouritePokemonsFetchSuccessful){
                    favouriteCounter.value = state.pokemon.length ;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}
