import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart'; // 고객센터 채팅형식을 위한 import
import 'package:http/http.dart' as http;

class AdminCustomerService extends StatefulWidget {
  final String uId;
  const AdminCustomerService({Key? key, required this.uId}) : super(key: key);

  @override
  State<AdminCustomerService> createState() => _AdminCustomerServiceState();
}

class _AdminCustomerServiceState extends State<AdminCustomerService> {
  // Property
  late TextEditingController sendField;
  late List data;

  late String csContent;
  late int csAdmin;
  late String uId;

  @override
  void initState() {
    super.initState();
    sendField = TextEditingController();
    data = [];
    csContent = '';
    csAdmin = 1;
    uId = widget.uId;
    getJSONData();
  }

  @override
  void dispose() {
    sendField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('$uId님의 문의내역'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                // 키보드 올라오는 공간 고려, 반응형 사이즈박스
                height: 580 - MediaQuery.of(context).viewInsets.bottom,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    // bubble을 리스트뷰로 촤르륵 띄워보자, data[index]
                    if (data[index]['csAdmin'] == 1) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BubbleNormal(
                          color: Colors.grey,
                          text: data[index]['csContent'], // DB : select
                          textStyle: const TextStyle(fontSize: 20),
                          isSender: true,
                          tail: true,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BubbleNormal(
                          color: Colors.deepPurple,
                          text: data[index]['csContent'], // DB : select
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          isSender: false,
                          tail: true,
                        ),
                      );
                    }
                  },
                  itemCount: data.length,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                    ),
                    cursorColor: Colors.blueGrey,
                    controller: sendField,
                    onSubmitted: (value) {
                      setState(() {
                        if (sendField.text.trim().isNotEmpty) {
                          csContent = sendField.text;
                          insertAction().then((context) => getJSONData());
                        }
                        sendField.text = ''; // text field 비우기
                        csContent = '';
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    onPressed: () {
                      setState(() {
                        if (sendField.text.trim().isNotEmpty) {
                          csContent = sendField.text;
                          insertAction().then((context) => getJSONData());
                          csContent = '';
                        }
                        sendField.text = ''; // text field 비우기
                      });
                    },
                    child: const Text('답변')),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Functions
  Future getJSONData() async {
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/customer_service_select.jsp?uId=$uId');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    setState(() {
      data = []; // 초기화 안하면 계속 누적되어서 출력된다.
      data.addAll(result);
    });
  }

  insertAction() async {
    print(csAdmin);
    var url = Uri.parse(
      'http://localhost:8080/Flutter/fitness/customer_service_insert.jsp?csContent=$csContent&csAdmin=$csAdmin&uId=$uId',
    );
    var response = await http.get(url);
    setState(
      () {
        var dataConvertedJSON = json.decode(
          utf8.decode(response.bodyBytes),
        );
        String result = dataConvertedJSON['result'];

        if (result == 'OK') {
          _showDialog(context);
          Navigator.pop(context);
        } else {
          _errorSnackBar(context);
        }
      },
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('입력 결과'),
          content: const Text('입력이 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  _errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 입력에 문제가 발생했습니다.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }
}
