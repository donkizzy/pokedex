

import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';

class ProgressBar extends StatelessWidget {

  final double current;
  final Color color;

  const ProgressBar(
      {Key? key,
        required this.current,
        required this.color })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, boxConstraints) {
        var x = boxConstraints.maxWidth;
        var percent = (current / 100) * x;
        return Stack(
          children: [
            Container(
              width: x,
              height: 5,
              decoration: BoxDecoration(
                color: mecuryGrey,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: percent,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ],
        );
      },
    );
  }
}
