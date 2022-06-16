import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:korean_fitness/Login/log_in.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: const Text(
        "스마트 운동 파트너",
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 47, 40, 100),
        ),
      ),
      backgroundImage: const AssetImage(
        // "images/fitnesscenter1.png",
        "images/FITNESS5.png",
      ),
      
      showLoader: true,
      loadingText: const Text(
        "Loading...",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      navigator: const LogIn(),
      durationInSeconds: 4,
      loaderColor: Colors.black,
      logoSize: 1,
      loadingTextPadding: EdgeInsets.fromLTRB(20, 20, 20, 100),
    );
  }
}