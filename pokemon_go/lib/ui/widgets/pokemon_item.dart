



import 'package:flutter/material.dart';
import 'package:pokemon_go/models/pokemon.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/utilities.dart';
import 'package:pokemon_go/ui/views/pokemon_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon ;
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PokeMonDetail(pokemon: pokemon,)));
      },
      child: Hero(
        tag: pokemon.pokemonDetails.id.toString(),
        child: Material(
            borderRadius:const  BorderRadius.only(bottomRight:  Radius.circular(4.0),bottomLeft:  Radius.circular(4.0)),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Flexible(
                  child: Container(
                    // height: height(context) / 7,
                    decoration: BoxDecoration(
                      color: pokemon.bgColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: pokemon.pokemonDetails.sprites!.other.officialArtwork.frontDefault,
                        height: 70,
                        //alignment: Alignment.center,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,strokeWidth: 2,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    ceruleanBlue),
                                backgroundColor: doveGrey,),
                            ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                         const SizedBox(height: 10,),
                        Text('#00${pokemon.pokemonDetails.id} ',style:const  TextStyle(
                            color: doveGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),),
                        const  SizedBox(height: 3,),
                          Text(pokemon.pokemonDetails.name!.toCapitalize(),style: const TextStyle(
                            color: mirageBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),overflow: TextOverflow.ellipsis,),
                        Expanded(
                          child: Text(pokemon.types,style: const TextStyle(
                              color: doveGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),overflow: TextOverflow.ellipsis,),
                        ),
                        //const   SizedBox(height: 10,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}
