import 'dart:async';
import 'dart:convert';

import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:korean_fitness/Setting/mypage.dart';
import 'package:korean_fitness/message.dart';
import 'package:korean_fitness/message5.dart';
import 'package:reveal_card/reveal_card.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MuscularStrength extends StatefulWidget {
  
  final List<exercise> listM;
  final List<exercise> listC;
  final List<exercise> listF;
  final List<exercise> listS;


  const MuscularStrength({
    Key? key,
    required this.listM,
    required this.listC,
    required this.listF,
    required this.listS,
  }) : super(key: key);
  
  @override
  State<MuscularStrength> createState() => _MuscularStrengthState();
}

class _MuscularStrengthState extends State<MuscularStrength> {
  late String type;
  late Color col;
  late Color col2;
  late List<exercise> listX;
  late String ment1;
  late String ment2;
  late String add1;
  late String add2;
  late String add3;
  late String add4;
  late String add5;
  late String add6;
  late String add7;
  late String add8;
  late String add9;
  late String add10;
  late String add11;
  late String add12;
  late double jump1;
  late double jump2;
  late double jump3;
  late double jump4;
  late double jump5;
  late Curve cu; //!@
  late int num;
  late int page;
  late List numList;

 late List starM;
 late List starC;
 late List starF;
 late List starS;

 late List starList;

late String result;
 
 
  //drawer id, name, email
  late String finalId;
  late String finalName;
  late String finalEmail;

  var lista = List.generate(50, (index) => index);

  @override
  void initState() {

  page = 1;

    type = '근력';
    col = Color.fromARGB(150, 43, 9, 0);
    col2 = Colors.orange;
    listX = widget.listM;
    ment1 = '근력 향상 운동';
    ment2 = '맨몸운동, 웨이트 트레이닝, 저항밴드운동';
    add1 = '근력(Muscular Strength) :';
    add2 = '';
    add3 = '';
    add4 = '근육이 발휘하는 힘';
    add5 = '근지구력(Muscular Endurance) :';
    add6 = '';
    add7 = '';
    add8 = '근육이 운동을 오래 지속하는 능력';
    add9 = '근력이 근수축력에 의해 발휘되는 힘이라면';
    add10 = '';
    add11 = '근지구력은 근수축의 지속시간을 의미한다.';
    add12 = '';
    jump1 = 30;
    jump2 = 30;
    jump3 = 30;
    jump4 = 30;
    jump5 = 10;

  

    cu = Curves.easeInOutBack;
    num = 900;

    starM = [false,false,false,false,false,false,false,false,false,false,false,false];
    starC = [false,false,false,false,false,false,false,false,false,false,false,false];
    starF = [false,false,false,false,false,false,false,false,false,false,false,false];
    starS = [false,false,false,false,false,false,false,false,false,false,false,false];
    
    starList = []; 
    numList = [];

    favoriteGetJSONData(1);

    super.initState();


    
    finalId = "";
    finalName = "";
    finalEmail = "";
    getData();
    super.initState();
  }

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Future getData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obitainedid = sharedPreferences.getString('id');
    var obitainedEmail = sharedPreferences.getString('email');
    var obitainedName = sharedPreferences.getString('name');

    setState(() {
      if (obitainedid == null) {
        finalId = "";
      } else {
        finalId = obitainedid;
        finalEmail = obitainedEmail!;
        finalName = obitainedName!;
      }
    });
    Message.uId = finalId;
    Message.uEmail = finalEmail;
    Message.uName = finalName;
    print("분석메인 $finalId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('체력향상 프로그램',
        style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w600, color: Colors.black),),
        toolbarHeight: 65,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            Container(
              color: Color.fromARGB(180, 162, 182, 255),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = 1;
                        listX = widget.listM;
                        starList = starM;
                        print("abc");
                        favoriteGetJSONData(1);
                        type = '근력';
                        col = Color.fromARGB(150, 43, 9, 0);
                        col2 = Colors.orange;
                        ment1 = '근력 향상 운동';
                        ment2 = '맨몸운동, 웨이트 트레이닝, 저항밴드운동';
                        add1 = '근력(Muscular Strength) :';
                        add2 = '';
                        add3 = '';
                        add4 = '근육이 발휘하는 힘';
                        add5 = '근지구력(Muscular Endurance) :';
                        add6 = '';
                        add7 = '';
                        add8 = '근육이 운동을 오래 지속하는 능력';
                        add9 = '근력이 근수축력에 의해 발휘되는 힘이라면';
                        add10 = '';
                        add11 = '근지구력은 근수축의 지속시간을 의미한다.';
                        add12 = '';
                        jump1 = 30;
                        jump2 = 30;
                        jump3 = 30;
                        jump4 = 30;
                        jump5 = 10;
                        cu = Curves.bounceOut;
                        num = 1200;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/mu1.png',
                      ),
                      radius: 33,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        page = 2;
                        listX = widget.listC;
                        starList = starC;
                        favoriteGetJSONData(2);
                        type = '심폐지구력';
                        col = Color.fromARGB(149, 0, 43, 23);
                        col2 = Colors.lightGreen;
                        ment1 = '심폐지구력 향상 운동';
                        ment2 = '달리기, 수영, 테니스, 축구, 농구';
                        add1 = '심폐지구력(Cardiovascular) :';
                        add2 = '';
                        add3 = '';
                        add4 = '호흡기관이나 순환계가 오랜 시간 동안';
                        add5 = '';
                        add6 = '계속되는 운동이나 일에 견딜 수 있는 능력';
                        add7 = '2가지 운동으로 분류 :';
                        add8 = '';
                        add10 = '운동 강도가 거의 일정한 운동,';
                        add9 = '';
                        add12 = '강도가 일정치 않아 심박수변화 심한 운동';
                        add11 = '';
                        jump1 = 30;
                        jump2 = 10;
                        jump3 = 30;
                        jump4 = 10;
                        jump5 = 10;
                        cu = Curves.bounceOut;
                        num = 1200;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/ca1.png',
                      ),
                      radius: 33,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                           page = 3;
                        listX = widget.listF;
                        starList = starF;
                        favoriteGetJSONData(3);
                        type = '유연성';
                        col = Color.fromARGB(149, 1, 0, 43);
                        col2 = Colors.lightBlueAccent;
                        ment1 = '유연성 향상 운동';
                        ment2 = '요가, 필라테스, 스트레칭';
                        add1 = '유연성(Flexibility) :';
                        add4 = '정적, 동적 상태에서 관절의 가동범위와';
                        add6 = '근육이나 관절 주변조직 인대,힘줄 등의';
                        add8 = '신장능력에 의해 결정되는 것으로';
                        add10 = '정확하고 부드러운 움직임을 일으키는 능력';
                        add2 = '';
                        add3 = '';
                        add5 = '';
                        add7 = '';
                        add9 = '';
                        add11 = '';
                        add12 = '';
                        jump1 = 30;
                        jump2 = 10;
                        jump3 = 10;
                        jump4 = 10;
                        jump5 = 10;
                        cu = Curves.bounceOut;
                        num = 1200;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/fl1.png',
                      ),
                      radius: 33,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                       
                        listX = widget.listS;
                        starList = starS;
                         favoriteGetJSONData(4);
                        print("S : $starS");
                        print(starList);
                        page = 4;
                        type = '순발력';
                        col = Color.fromARGB(160, 90, 4, 101);
                        col2 = Colors.pinkAccent;
                        ment1 = '순발력 향상 운동';
                        ment2 = '사이드 스텝, 왕복 달리기, 부메랑 런';
                        add1 = '순발력(Power) :';
                        add4 = '아주 짧은 시간에 최대의 힘을 ';
                        add6 = '발휘하기 위한 근신경계의 능력';
                        add8 = '순발력 = 힘 x 속도';
                        add9 = '민첩성(Agility) :';
                        add12 = '운동의 방향을 신속히 바꿀 수 있는 능력 ';
                        add2 = '';
                        add3 = '';
                        add5 = '';
                        add7 = '';
                        add10 = '';
                        add11 = '';
                        jump1 = 30;
                        jump2 = 10;
                        jump3 = 10;
                        jump4 = 30;
                        jump5 = 30;
                        cu = Curves.bounceOut;
                        num=1200;
                      });
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'images/sp1.png',
                      ),
                      radius: 33,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: const Size(350, 30),
            //       primary: col,
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(30))),
            //   child: Text(
            //     '$type 향상을 위한 운동',
            //     style: const TextStyle(fontSize: 25),
            //   ),
            // ),
            //const SizedBox(height: 5),
            RevealCard(
              height: 220,
              width: 350,
              title: Text(
                '$type 운동',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
              revealIcon: const Icon(Icons.add_to_photos,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
              backgroundImage: const NetworkImage(
                  'https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/12/106357558.1.jpg'),
              content: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: jump1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add3,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add4,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: jump2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add5,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add6,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: jump3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add7,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add8,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: jump4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add9,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add10,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: jump5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(add11,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ])),
                    Expanded(
                      child: Text(
                        add12,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
              revealBackgroundImage: const NetworkImage(
                'https://dimg.donga.com/wps/NEWS/IMAGE/2021/04/12/106357558.1.jpg',
              ),
              revealCloseIcon: const Icon(Icons.close,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ]),
              revealTitle: Text(
                ment1,
                style: const TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
              revealContent: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      ment2,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 170,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CardLoading(
              cardLoadingTheme: CardLoadingTheme(
                  colorOne: const Color.fromARGB(255, 243, 243, 243),
                  colorTwo: col2,
                  ),
              height: 3,
              borderRadius: 40,
              margin: const EdgeInsets.only(bottom: 10),
              curve: Curves.easeInToLinear,
              animationDuration:const Duration(milliseconds:1400),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: listX.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () => _showDialog(
                          context,
                          listX[position],
                        ),
                        child: Container(
                          color: const Color.fromARGB(255, 243, 243, 243),
                          child: AnimatedCard(
                            direction: AnimatedCardDirection.left,
                            initDelay: const Duration(milliseconds: 0),
                            duration: Duration(milliseconds: num), 
                            curve: cu,
                            child: Row(
                              children: [
                                Image.asset(
                                  listX[position].imagePath,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                     width: 210,
                                     decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color:col))),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(listX[position].exName,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                              color: col2,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            listX[position].exCount,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: col,
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Checkbox(
                                      value: numList.contains(position) == true ? true : false,
                                      // iconDisabledColor: Colors.white,
                                      onChanged: (_isStarred) {
                                        
                                        if (_isStarred == true){
                                          insertAction(page, position);
                                          
                                        }else{
                                          deleteAction(page, position);
                                        }
                                                                  
                                      },
                                    )
                                  ],
                                ),
                                
                              ],
                            ),
                            
                          ),
                        ),
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 5,
             ),
            // CardLoading(
            //   cardLoadingTheme: CardLoadingTheme(
            //       colorOne: const Color.fromARGB(255, 243, 243, 243),
            //       colorTwo: col2),
            //   height: 3,
            //   borderRadius: 40,
            //   margin: const EdgeInsets.only(bottom: 10),
            //   curve: Curves.easeInToLinear,
            //   animationDuration:const Duration(milliseconds:1400),
            // ),

            // Expanded(
            //   child: Container(
            //     child: VerticalCardPager(
            //       titles: titles,  // required
            //       images: images,  // required
            //       textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // optional
            //       onPageChanged: (page) { // optional
            //       },
            //       onSelectedItem: (index) { // optional
            //       // Navigator.push(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //         builder: (context) => DetailView(
            //       //               // champion:
            //       //               //     championsMap[titles[index].toLowerCase()],
            //       //             ));
            //       },
            //       initialPage: 0, // optional
            //       align : ALIGN.CENTER // optional
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          //패딩 없이 꽉 채우기
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              //상단에 이미지 넣기
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage(
                  'images/logo.png',
                  ),
              ),
              //이미지 밑에 이름 & 이메일
              accountName: Text('${Message.uName}님'),
              accountEmail: Text(Message.uEmail),
              decoration: const BoxDecoration(
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
            ListTile(
              onTap: () async{
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove("id");
                _handleSignOut();
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, '/Log_in');
              },
              leading: const Icon(
                Icons.logout,
                // color: Colors.deepPurple,
              ),
              title: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context, exercise exercise) {
    showDialog(
        context: context,
        barrierDismissible: false, // 종료를 눌러야만 알러트 창 꺼진다.
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text("이 운동의 이름은"),
            content: Text(" ${exercise.exName} 입니다."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('종료'),
              ),
            ],
          );
        });


        
  }

    Future<bool> favoriteGetJSONData(int exName) async {
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Center(child: CircularProgressIndicator());
    //   },
    // );

    starList = [];

    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/favorite_select.jsp?id=${Message.uId}&exName=$exName");
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSOn = json.decode(utf8.decode(response.bodyBytes));

      List result = dataConvertedJSOn['results'];

      starList.addAll(result);
    
numList = [];

    for (int i = 0; i < starList.length; i++ ){
 numList.add(starList[i]['exNum']);

}

    });




    //  print(double.parse(Message3.mLatitude));

    // print(result);


    return true;
  }

  insertAction(int exName, int exNum) async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/favorite_insert.jsp?id=${Message.uId}&exName=$exName&exNum=$exNum');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

  
    });
    favoriteGetJSONData(page);
  }

    deleteAction(int exName, int exNum) async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/favorite_delete.jsp?Id=${Message.uId}&exName=$exName&exNum=$exNum');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

  
    });
    favoriteGetJSONData(page);
  }



  
}
