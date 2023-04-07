import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/app_constant.dart';
import 'package:shimmer/shimmer.dart';

class PokemonLoader extends StatefulWidget {
  const PokemonLoader({Key? key}) : super(key: key);

  @override
  State<PokemonLoader> createState() => _PokemonLoaderState();
}

class _PokemonLoaderState extends State<PokemonLoader> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: 9,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 12,
        childAspectRatio: width(context) / (height(context) - 100),
      ),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          highlightColor: doveGrey.withOpacity(0.2),
          baseColor: doveGrey.withOpacity(0.1),
          enabled: true,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0)),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
