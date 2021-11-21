import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_go/bloc/favourite_pokemons/favourite_pokemons_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_bloc.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_event.dart';
import 'package:pokemon_go/bloc/fetch_pokemons/fetch_pokemon_state.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/app_constant.dart';
import 'package:pokemon_go/ui/widgets/all_pokemon.dart';
import 'package:pokemon_go/ui/widgets/pokemon_item.dart';
import 'package:pokemon_go/ui/widgets/pokemon_loader.dart';
import 'package:pokemon_go/ui/widgets/rectangle_tab_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late FetchPokemonBloc _fetchPokemonBloc;

  late FavouritePokemonsBloc _favouritePokemonsBloc;

  List<Pokemon> pokemonList = <Pokemon>[];
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    _fetchPokemonBloc = FetchPokemonBloc();
    _favouritePokemonsBloc = BlocProvider.of<FavouritePokemonsBloc>(context);
    _favouritePokemonsBloc.add(const FetchFavouritePokemon());
    _fetchPokemonBloc.add(const FetchPokemon());

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
                        'All Pokemon\'s',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          const Text('Favourites',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ceruleanBlue,
                            ),
                            child: const Center(
                              child: Text('20',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ),
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
                            _fetchPokemonBloc.add(const FetchPokemon());
                          },
                          child: const Text('Retry'),
                          color: ceruleanBlue,
                          textColor: Colors.white,
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
                      decoration: BoxDecoration(
                        color: doveGrey.withOpacity(0.1),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(12),
                        itemCount: state.pokemon.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio:
                              width(context) / (height(context) - 100),
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
                            _favouritePokemonsBloc
                                .add(const FetchFavouritePokemon());
                          },
                          child: const Text('Retry'),
                          color: ceruleanBlue,
                          textColor: Colors.white,
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
                  if (state is SaveFavouritePokemonsSuccessful) {
                    _favouritePokemonsBloc.add(const FetchFavouritePokemon());
                  }
                  if (state is RemoveFavouritePokemonsSuccessful) {
                    _favouritePokemonsBloc.add(const FetchFavouritePokemon());
                  }
                  if (state is CheckFavouritePokemonsSuccessful) {
                    _favouritePokemonsBloc.add(const FetchFavouritePokemon());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

