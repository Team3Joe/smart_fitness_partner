import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:korean_fitness/Login/log_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:korean_fitness/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String? finalId;
  
  late String id;
  late String pw;
  late int uq; //user탈퇴여부

  late List data;
  

@override
  void initState() {
    getData().whenComplete(() async{
     Timer(Duration(seconds: 2),() => Get.to(finalId == "" ? Navigator.pushNamed(context,'/Log_in') : Navigator.pushNamed(context, '/Mainpage')));
    });

     id = '';
    pw = '';
    uq = 0;
    data = [];
    super.initState();
  }

Future getData() async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var obitainedId = sharedPreferences.getString('id');


  setState(() {
    if(obitainedId == null){
      finalId = "";
    }else{
    finalId = obitainedId;
    
    }
  });
  print("로딩 : $finalId");
}

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
      
      loaderColor: Colors.black,
      logoSize: 0,
      loadingTextPadding: EdgeInsets.fromLTRB(20, 20, 20, 100),
    );
  }
  Future<bool> _getJSONData() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/user_select.jsp?id=$id&pw=$pw');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    setState(() {
      data = [];
      data.addAll(result);
    });
    if (data.isEmpty) {
      //없는 계정입력시
      return true;
    } else {
      var userquite = data[0]['uQuit']; //탈퇴여부 값 받아오기
      uq = userquite;
      Message.uId = data[0]['uId'];
      Message.uPw = data[0]['uPw'];
      Message.uName = data[0]['uName'];
      Message.uBirth = data[0]['uBirth'];
      Message.uEmail = data[0]['uEmail'];
      return true;
    }
  }
}//end