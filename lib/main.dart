import 'package:KubernetesMobile/Animation/Splash.dart';
import 'package:KubernetesMobile/authentication.dart';
import 'package:KubernetesMobile/FrontEnd.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'FrontEnd.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(KubernetesMobile());
}

class KubernetesMobile extends StatelessWidget {
  final appTitle = 'Docker';

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueAccent.shade700);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.blueAccent.shade700);
    //RepoHub();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: AnimatedSplashScreen(
          splash: Splash(),
          nextScreen: Auth(),
          duration: 6000,
          splashIconSize: double.infinity,
        )

        /*SplashScreen(
            seconds: 50000,
            navigateAfterSeconds: Dashboard(), //Auth(),
            title: new Text(
              'KubernetesMobile',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.blue),
            ),
            image: new Image.asset("images/kube1.png"),
            backgroundColor: Colors.white,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 170,
            loadingText: Text(
              "Loading",
              style: TextStyle(color: Colors.grey),
            ),
            loaderColor: Colors.blue.shade800)*/

        );
  }
}
