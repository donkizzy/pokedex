



import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/views/pokemon_detail.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const PokeMonDetail()));
      },
      child: Container(
        height: 186,
        width: 112,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(4.0),bottomLeft: Radius.circular(4.0))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Container(
              height: 120,
              width: 118,
              decoration: BoxDecoration(
                color: ceruleanBlue.withOpacity(0.4),

              ),
              child: Center(child: Image.asset('assets/test_pokemon.png',height: 70,)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:const [
                  SizedBox(height: 10,),
                  Text('#001',style: TextStyle(
                      color: doveGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 3,),
                  Text('Bulbasaur',style: TextStyle(
                      color: mirageBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 10,),
                  Text('Grass, Poison',style: TextStyle(
                      color: doveGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),),
                  SizedBox(height: 5,),
                ],
              ),
            )
          ],
        ),
      ),
    ) ;
  }
}
