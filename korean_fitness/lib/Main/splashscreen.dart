import 'dart:async';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? finalId;
  String? finalName;
  String? finalEmail;

  @override
  void initState() {
    getData().whenComplete(() async {
      Timer(
          const Duration(seconds: 2),
          () => Get.to(finalId == ""
              ? Navigator.pushNamed(context, '/Log_in')
              : Navigator.pushNamed(context, '/Mainpage')));
    });
    super.initState();
  }

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obitainedId = sharedPreferences.getString(' id');
    var obitainedName = sharedPreferences.getString('name');
    var obitainedEmail = sharedPreferences.getString('email');

    setState(() {
      if (obitainedId == null) {
        finalId = "";
      } else {
        finalId = obitainedId;
        finalName = obitainedName;
        finalEmail = obitainedEmail;
      }
    });
    print("로딩 : $finalId");
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset(
          'images/logo.png'),
      // title: Text(
      //   "스마트 운동 파트너",
      //   style: TextStyle(
      //       fontSize: 45,
      //       fontWeight: FontWeight.bold,
      //       color: const Color.fromARGB(255, 48, 30, 90),
      //       shadows: [
      //         Shadow(
      //             color: Colors.white.withOpacity(0.7),
      //             offset: const Offset(3, 3),
      //             blurRadius: 12)
      //       ]),
      // ),
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
      loaderColor: Colors.black,
      logoSize: 165,
      loadingTextPadding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
    );
  }
}
