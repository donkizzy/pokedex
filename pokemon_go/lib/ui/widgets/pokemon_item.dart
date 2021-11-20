



import 'package:flutter/material.dart';
import 'package:pokemon_go/models/pokemon_detail_response.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/app_constant.dart';
import 'package:pokemon_go/shared/utilities.dart';
import 'package:pokemon_go/ui/views/pokemon_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonItem extends StatelessWidget {
  final PokemonDetailResponse pokeMonDetail ;
  final String  types ;
  final int  averagePower ;
  final Color bgColor;
  const PokemonItem({Key? key, required this.pokeMonDetail,required this.types,required this.averagePower,required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PokeMonDetail(pokeMonDetail: pokeMonDetail,types: types,averagePower: averagePower,bgColor: bgColor,)));
      },
      child: Hero(
        tag: pokeMonDetail.id.toString(),
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(4.0),bottomLeft: Radius.circular(4.0))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Container(
                height: height(context) /8,
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.2),
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl:pokeMonDetail.sprites!.other.officialArtwork.frontDefault,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text('#00${pokeMonDetail.id} ',style:const  TextStyle(
                        color: doveGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),),
                    const  SizedBox(height: 3,),
                      Text(pokeMonDetail.name!.toCapitalize(),style: const TextStyle(
                        color: mirageBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),overflow: TextOverflow.ellipsis,),
                    const   SizedBox(height: 10,),
                    Text(types,style: const TextStyle(
                        color: doveGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ) ;
  }
}
