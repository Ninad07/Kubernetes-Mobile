import 'package:KubernetesMobile/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:loading_animations/loading_animations.dart';
import 'package:show_up_animation/show_up_animation.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueAccent.shade700,
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          ShowUpAnimation(
            direction: Direction.vertical,
            delayStart: Duration(seconds: 1),
            animationDuration: Duration(seconds: 2),
            curve: Curves.easeIn,
            child: Container(
              height: 280,
              width: 280,
              child: Image.asset(
                "images/kube1.png",
                height: 200,
                width: 200,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ShowUpAnimation(
            direction: Direction.horizontal,
            delayStart: Duration(seconds: 2),
            animationDuration: Duration(seconds: 2),
            curve: Curves.easeIn,
            child: Container(
              width: 350,
              child: Center(
                child: Text(
                  "Kubernetes",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ShowUpAnimation(
            direction: Direction.horizontal,
            delayStart: Duration(seconds: 3),
            animationDuration: Duration(seconds: 2),
            curve: Curves.easeIn,
            child: Container(
              width: 350,
              height: 35,
              child: Center(
                child: Text(
                  "mobile",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 5,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
          /*FadeAnimation(
            8,
            Container(
              width: 350,
              height: 35,
              child: Center(
                child: Text(
                  "mobile",
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 5,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
          ),*/
          SizedBox(
            height: 130,
          ),
          /*Loading(
            indicator: LineScaleIndicator(),
            color: Colors.white,
            size: 40,
          )*/

          LoadingFadingLine.circle(
            borderColor: Colors.white,
            borderSize: 3.0,
            size: 50.0,
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Center(
              child: Text(
                "loading",
                style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
