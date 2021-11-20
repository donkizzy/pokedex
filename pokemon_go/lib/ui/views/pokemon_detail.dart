import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/widgets/stat_item.dart';

class PokeMonDetail extends StatefulWidget {
  final PokemonDetailResponse pokeMonDetail;
  final String  types ;
  final int  averagePower ;

  const PokeMonDetail({Key? key, required this.pokeMonDetail, required this.types, required this.averagePower})
      : super(key: key);

  @override
  _PokeMonDetailState createState() => _PokeMonDetailState();
}

class _PokeMonDetailState extends State<PokeMonDetail> {
  late PokemonDetailResponse pokeMonDetail;
  late String  types ;
  late int  averagePower ;

  ValueNotifier<bool> showFavouriteButton = ValueNotifier<bool>(true);

  @override
  void initState() {
    pokeMonDetail = widget.pokeMonDetail;
    types = widget.types ;
    averagePower = widget.averagePower ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder(
        valueListenable: showFavouriteButton,
        builder: (BuildContext context, bool value, Widget? child) {
          return value
              ? GestureDetector(
                  onTap: () {
                    showFavouriteButton.value = !value;
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
                    showFavouriteButton.value = !value;
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
        },
      ),
      appBar: AppBar(
        backgroundColor: ceruleanBlue.withOpacity(0.2),
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
                color: ceruleanBlue.withOpacity(0.2),
                image: DecorationImage(
                    image: const AssetImage(
                      'assets/pokemon_bg.png',
                    ),
                    alignment: Alignment.centerRight,
                    colorFilter: ColorFilter.mode(
                        ceruleanBlue.withOpacity(0.6), BlendMode.srcATop))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${pokeMonDetail.name}',
                  style: const TextStyle(
                      color: mirageBlue,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                 Text( types,
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
                      Image.network(
                        pokeMonDetail
                            .sprites!.other.officialArtwork.frontDefault,
                        height: 125,
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
                      (pokeMonDetail.weight! /
                              (pokeMonDetail.weight! * pokeMonDetail.weight!))
                          .toStringAsFixed(2),
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
            score: double.parse((averagePower /6).toStringAsFixed(2)),
            title: 'Avg. Power',
            progressColor: cerisePink,
          ),
        ],
      ),
    );
  }


}
