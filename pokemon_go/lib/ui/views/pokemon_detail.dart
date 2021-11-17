

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/widgets/custom_linear_indicator.dart';
import 'package:pokemon_go/ui/widgets/stat_item.dart';

class PokeMonDetail extends StatefulWidget {
  const PokeMonDetail({Key? key}) : super(key: key);

  @override
  _PokeMonDetailState createState() => _PokeMonDetailState();
}

class _PokeMonDetailState extends State<PokeMonDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
            padding: const EdgeInsets.symmetric(horizontal:20),
            decoration:  BoxDecoration(
              color: ceruleanBlue.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Text('Bulbasaur',style: TextStyle(
                    color: mirageBlue,
                    fontSize: 32,
                    fontWeight: FontWeight.w700
                ),),
                const Text('Grass, Poison',style: TextStyle(
                    color: mirageBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                ),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                  const  Text('#001',style: TextStyle(
                        color: mirageBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                    ),),
                    Image.asset('assets/test_pokemon.png',height: 125,)
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Column(
                  children: const [
                    Text('Height',style: TextStyle(
                        color: doveGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    Text('69',style: TextStyle(
                        color: mirageBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),),

                  ],
                ),
                const SizedBox(width: 50,),
                Column(
                  children: const [
                    Text('Weight',style: TextStyle(
                        color: doveGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    Text('9',style: TextStyle(
                        color: mirageBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),),

                  ],
                ),
                const SizedBox(width: 50,),
                Column(
                  children: const [
                    Text('BMI',style: TextStyle(
                        color: doveGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),),
                    Text('69.2',style: TextStyle(
                        color: mirageBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),),

                  ],
                ),
                const SizedBox(width: 20,),

              ],
            ),
          ),
          Divider(
            color: doveGrey.withOpacity(0.1),thickness: 7,),
          const Padding(
            padding:  EdgeInsets.only(left:20,top: 12),
            child:  Text('Base stats',style: TextStyle(
                color: mirageBlue,
                fontSize: 16,
                fontWeight: FontWeight.w600
            ),),
          ),
          Divider(
            color: doveGrey.withOpacity(0.1),thickness: 1,),
         const  SizedBox(height: 16,),
          const StatsItem(score: 20.0,title: 'HP',progressColor: cerisePink,),
          const StatsItem(score: 30.0,title: 'Attack',progressColor: cerisePink,),
          const StatsItem(score: 30.0,title: 'Defense',progressColor: cerisePink,),
          const StatsItem(score: 40.0,title: 'Special Attack',progressColor: goldTipsYellow,),
          const StatsItem(score: 40.0,title: 'Special Defense',progressColor: goldTipsYellow,),
          const StatsItem(score: 10.0,title: 'Speed',progressColor: cerisePink,),
          const StatsItem(score: 30.0,title: 'Avg. Power',progressColor: cerisePink,),
        ],
      ),
    );
  }
}
