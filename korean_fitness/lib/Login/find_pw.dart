import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FindPw extends StatefulWidget {
  const FindPw({Key? key}) : super(key: key);

  @override
  State<FindPw> createState() => _FindPwState();
}

class _FindPwState extends State<FindPw> {
  // Property
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController emailController;
  late TextEditingController modifyPWField;
  late String name;
  late String email;
  late String id;
  late String pw;
  late int uq; //user 탈퇴현황

  late List data;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    idController = TextEditingController();
    emailController = TextEditingController();
    modifyPWField = TextEditingController();
    name = '';
    id = '';
    email = '';
    pw = '';
    uq = 0;

    data = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            foregroundColor: Color.fromARGB(255, 164, 154, 239),
            title: const Text(
              "비밀번호 찾기",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 30, 0, 65),
              ),
            ),
            toolbarHeight: 100,
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text(
                        "아이디 : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 30, 0, 65),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: idController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your ID',
                            filled: true,
                            fillColor: Color.fromARGB(230, 231, 229, 255),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 69, 41, 152),
                            ),
                            hintStyle: TextStyle(
                             color: Color.fromARGB(159, 101, 71, 191),
                             fontSize: 14
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(width: 1.8, color: Color.fromARGB(255, 61, 51, 133)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 91, 80, 177)),
                            ),
                          ),
                        keyboardType: TextInputType.text,
                        cursorColor: Color.fromARGB(255, 113, 103, 194),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 60,
                      child: Text(
                        "이메일 : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 30, 0, 65),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            filled: true,
                            fillColor: Color.fromARGB(230, 231, 229, 255),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 69, 41, 152),
                            ),
                            hintStyle: TextStyle(
                             color: Color.fromARGB(159, 101, 71, 191),
                             fontSize: 14
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(width: 1.8, color: Color.fromARGB(255, 61, 51, 133)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(width: 1, color: Color.fromARGB(255, 91, 80, 177)),
                            ),
                          ),
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color.fromARGB(255, 113, 103, 194),
                        onChanged: (value) {},
                      ),
                    ),
                  ]
                ),
                const SizedBox(
                  height: 30,
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 139, 128, 222),
                        minimumSize: const Size(80, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                onPressed: () {
                  if (idController.text.trim().isEmpty) {
                    emptyID(context);
                  } else if (emailController.text.trim().isEmpty) {
                    emptyEmail(context);
                  } else {
                    setState(() {
                      id = idController.text.trim();
                      email = emailController.text.trim();
                    });
                    getJSONData().then((value) => findPWCheck(context));
                    // data 오류
                  }
                },
                child: const Text('PW 찾기'),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '아직 회원이 아니신가요?',
                            style: TextStyle(
                              color: Color.fromARGB(255, 23, 0, 60),
                              fontSize: 13,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Sign_up');
                            },
                            child: const Text(
                              '회원가입 하기',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  emptyID(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('이름을 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  emptyEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('email을 입력하세요.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<bool> getJSONData() async {
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/user_find_pw.jsp?id=$id&email=$email');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    // 행렬의 형태로 result에 저장한다.

    setState(() {
      data = []; // 초기화 안하면 계속 누적되어서 출력된다.
      data.addAll(result);
    });
    if (data.isEmpty) {
      return true;
    } else {
      pw = data[0]['uPw'];
      var userquite = data[0]['uQuit']; //탈퇴여부 값 받아오기
      uq = userquite;
      return true;
    }
  }

  findPWCheck(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        if (data.isEmpty) {
          return AlertDialog(
            title: const Text(
              'PW 찾기 실패!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text('ID와 email을 확인해주세요.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // resetPW();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        } else if(uq == 1){
          return AlertDialog(
            title: const Text(
              'PW 찾기 실패!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text('탈퇴한 계정입니다.\n계정복구를 원하시면 \n고객센터에 문의해주세요.'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // resetPW();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        }else {
          return AlertDialog(
            title: const Text(
              'PW 찾기 성공!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text('가입하신 ID의 PW는 $pw입니다.'),
            // content: TextField(
            //   controller: modifyPWField,
            //   decoration: const InputDecoration(labelText: '변경하실 PW를 입력하세요.'),
            // ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                  },
                  child: const Text('OK'))
            ],
          );
        }
      },
    );
  }

  // resetPW() async{
  //   var url = Uri.parse(
  //     'http://localhost:8080/flutter/student_update_return_flutter.jsp?code=$code&name=$name&dept=$dept&phone=$phone',
  //   );
  //   var response = await http.get(url);
  //   setState(
  //     () {
  //       var dataConvertedJSON = json.decode(
  //         utf8.decode(response.bodyBytes),
  //       );
  //       result = dataConvertedJSON['result'];

  //       if (result == 'OK') {
  //         Navigator.pop(context);
  //         _showDialog(context);
  //       } else {
  //         _errorSnackBar(context);
  //       }
  //     },

}
