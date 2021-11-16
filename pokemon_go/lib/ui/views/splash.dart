

import 'package:flutter/material.dart';
import 'package:pokemon_go/shared/app_colors.dart';
import 'package:pokemon_go/shared/app_constant.dart';
import 'package:pokemon_go/ui/views/home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ceruleanBlue,
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Center(
            child: Image.asset(
              'assets/splash_bg.png',
              height: 82,
            )),
      ),
    );
  }
}
