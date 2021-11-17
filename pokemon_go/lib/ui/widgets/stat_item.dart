

import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/ui/widgets/custom_linear_indicator.dart';

class StatsItem extends StatelessWidget {

  final String title ;
  final String score ;
  final Color progressColor ;
   const StatsItem({Key? key, required this.title,required this.score,required this.progressColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:  [
              Text(title,style: const TextStyle(
                  color: doveGrey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
              ),),
              const SizedBox(width: 5,),
              Text(score,style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),),
            ],
          ),
          const  SizedBox(height: 8,),
           ProgressBar(current: 20,color: progressColor,)
        ],
      ),
    ) ;
  }
}
