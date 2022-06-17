import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:korean_fitness/message.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // property

  late TextEditingController uIdController;
  late TextEditingController uPwController;
  late TextEditingController uNameController;
  late TextEditingController uBirthController;
  late TextEditingController uEmailController;

  // DB
  late String uId;
  late String uPw;
  late String uName;
  late String uBirth;
  late String uEmail;
  late List data;
  late String result;

  @override
  void initState() {
    super.initState();
    data = [];
    uIdController = TextEditingController();
    uPwController = TextEditingController();
    uNameController = TextEditingController();
    uBirthController = TextEditingController();
    uEmailController = TextEditingController();

    uId = Message.uId;
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(168, 111, 110, 110), //색변경
        ),
        title: const Text(
          'My Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 75,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 43),
                          child: Text('아이디 :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Text('비밀번호 :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Text('이름 :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Text('생년월일 :'),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Text('이메일 :'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'ID',
                                hintText: 'id를 입력해주세요!',
                                labelStyle:
                                    TextStyle(color: Colors.deepPurpleAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              controller: uIdController,
                              keyboardType: TextInputType.text,
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'PW',
                                hintText: '비밀번호를 입력해주세요!',
                                labelStyle:
                                    TextStyle(color: Colors.deepPurpleAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              controller: uPwController,
                              keyboardType: TextInputType.text,
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                hintText: '이름을 입력해주세요!',
                                labelStyle:
                                    TextStyle(color: Colors.deepPurpleAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              controller: uNameController,
                              keyboardType: TextInputType.text,
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Birth',
                                hintText: '생년월일을 6자로 입력해주세요!',
                                labelStyle:
                                    TextStyle(color: Colors.deepPurpleAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              controller: uBirthController,
                              keyboardType: TextInputType.text,
                            )),
                      ),
                      SizedBox(
                        width: 200,
                        height: 60,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: '이메일을 입력해주세요!',
                                labelStyle:
                                    TextStyle(color: Colors.deepPurpleAccent),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.deepPurpleAccent),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                              ),
                              controller: uEmailController,
                              keyboardType: TextInputType.emailAddress,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      uId = uIdController.text;
                      uPw = uPwController.text;
                      uName = uNameController.text;
                      uBirth = uBirthController.text;
                      uEmail = uEmailController.text;
                      updateAction();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 164, 154, 239),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      '수정',
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uId = uIdController.text;
                      _deleteShowDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 164, 154, 239),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      '회원탈퇴',
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

  //Functions

  Future getJSONData() async {
    data.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/mypage_select.jsp?uId=$uId");
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      //키값
      List value = dataConvertedJSON['results'];
      //데이터에 넣기
      data.addAll(value);
      uIdController.text = data[0]['uId'];
      uPwController.text = data[0]['uPw'];
      uNameController.text = data[0]['uName'];
      uBirthController.text = data[0]['uBirth'].toString();
      uEmailController.text = data[0]['uEmail'];
    });
  }

//functions

updateAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/mypage_user_update.jsp?uId=$uId&uPw=$uPw&uName=$uName&uBirth=$uBirth&uEmail=$uEmail');
    var response = await http.get(url);
    setState(() {
      var dataCovertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataCovertedJSON['result'];
      if (result == 'OK') {
        _updateShowDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  _updateShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('수정결과'),
            content: const Text('수정이 완료되었습니다!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Mypage');
                },
                child: const Text('예'),
              ),
            ],
          );
        });
  }

  deleteAction() async {
    print(uId);
    var url = Uri.parse('http://localhost:8080/Flutter/fitness/mypage_user_delete.jsp?uId=$uId');
    var response = await http.get(url);
    setState(() {
      var dataCovertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataCovertedJSON['result'];
      if (result == 'OK') {
        _deleteResultDialog(context);
        // _DeleteShowDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

   _deleteShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원 탈퇴'),
            content: const Text('정말로 탈퇴하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  deleteAction();
                  Navigator.pop(context);
                },
                child: const Text('예'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('아니오'),
              ),
            ],
          );
        });
  }

   _deleteResultDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('결과'),
            content: const Text('탈퇴가 완료되었습니다!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Log_in');
                },
                child: const Text('예'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('문제가 발생 하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

}
