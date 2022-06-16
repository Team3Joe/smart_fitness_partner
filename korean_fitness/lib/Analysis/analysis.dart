import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:korean_fitness/Analysis/select_gender.dart';
import 'package:korean_fitness/Calendar/calender.dart';
import 'package:korean_fitness/Main/mainpage.dart';
import 'package:korean_fitness/Setting/mypage.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "당신의 신체등급을 분석해보세요!",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
        ),
        backgroundColor: Colors.white10,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          const Text(
            "스마트 체력 테스트",
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 92, 29, 181),
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/bmi.png",
                    width: 80,
                    height: 80,
                    color: Colors.white.withOpacity(0.9), colorBlendMode: BlendMode.modulate,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "신체조성",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Image.asset(
                    "images/muscular_strength.png",
                    width: 80,
                    height: 80,
                    color: Colors.white.withOpacity(0.9), colorBlendMode: BlendMode.modulate,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "근력",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Image.asset(
                    "images/muscle_endurance.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "근지구력",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    "images/flexibility.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "유연성",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Image.asset(
                    "images/speed_strength.png",
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "순발력",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Image.asset(
                    "images/analysis.png",
                    width: 70,
                    height: 70,
                    color: Colors.white.withOpacity(0.8), colorBlendMode: BlendMode.modulate,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "분석",
                    style : TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(235, 110, 47, 199),
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5
          ),
          Image.asset(
            "images/chartexample.png",
            width: 270,
            height: 300,
          ),
          const SizedBox(
            height: 10
          ),
          OutlinedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/SelectGender');
              },
              style: OutlinedButton.styleFrom(
              minimumSize: const Size(100, 45),
                primary: Colors.deepPurpleAccent,
                side: const BorderSide(
                  color: Colors.deepPurple,
                  width: 2.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '스마트체력테스트 하러가기',
                    style: TextStyle(
                          color: Color.fromARGB(255, 98, 53, 164),
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                  ), // <-- Text
                  SizedBox(
                    width: 5,
                  ),
                  Icon( // <-- Icon
                    Icons.arrow_forward_rounded,
                    size: 24.0,
                  ),
                ],
              ),
            ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          //패딩 없이 꽉 채우기
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              //상단에 이미지 넣기
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/korea.png'),
              ),
              //이미지 밑에 이름 & 이메일
              accountName: Text('user name'),
              accountEmail: Text('user email'),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 164, 154, 239),
                //테두리, 값을 각각 줄 수 있음. all 은 한번에 다 뜸
              ),
            ),
            // 리스트
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((BuildContext context) => const MyPage())));
              },
              leading: const Icon(
                Icons.person,
                // color: Colors.deepPurple,
              ),
              title: const Text('My Page'),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/Setting');
              },
              leading: const Icon(
                Icons.settings,
                // color: Colors.deepPurple,
              ),
              title: const Text('설정'),
            ),
          ],
        ),
      ),
    );
  }
}