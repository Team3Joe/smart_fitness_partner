import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:korean_fitness/Admin/customer_service.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  // Property
  late TextEditingController searchField;
  late String search;
  late String uId;
  late List data;

  late int uQuitCount; // 탈퇴자 수 세기

  @override
  void initState() {
    super.initState();
    searchField = TextEditingController();
    search = '';
    uId = '';
    data = [];
    uQuitCount = 0;
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('관리자 페이지'),
            backgroundColor: Colors.blueGrey,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: const InputDecoration(
                              labelText: 'ID & 이름 검색',
                              labelStyle: TextStyle(color: Colors.blueGrey),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueGrey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey)),
                              focusColor: Colors.blueGrey),
                          cursorColor: Colors.blueGrey,
                          autocorrect: false,
                          controller: searchField,
                          onSubmitted: (value) {
                            setState(() {
                              if (searchField.text.trim().isNotEmpty) {
                                search = searchField.text.trim();
                                getJSONData();
                              }
                              searchField.text = ''; // text field 비우기
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          onPressed: () {
                            setState(() {
                              if (searchField.text.trim().isNotEmpty) {
                                search = searchField.text.trim();
                                getJSONData();
                              }
                              searchField.text = ''; // text field 비우기
                            });
                          },
                          child: const Text('검색')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey),
                          onPressed: () {
                            setState(() {
                              search = '';
                              getJSONData();
                            });
                          },
                          child: const Text('초기화')),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    '가입자 명단',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(),
                  Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(
                          'ID/Email',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 75,
                        child: Text(
                          '이름',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '기능',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: (data.length - uQuitCount) * 45 -
                          MediaQuery.of(context).viewInsets.bottom,
                      // 키보드 올라오는 공간 고려
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return data.isEmpty
                              ? const Text('데이터가 없습니다.')
                              : data[index]['uQuit'] == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AdminCustomerService(
                                                    uId: data[index]['uId']),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Card(
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 175,
                                                    child: Text(
                                                      data[index]['uId'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 75,
                                                    child: Text(
                                                      data[index]['uName'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blueGrey),
                                              ),
                                              onPressed: () {
                                                uId = data[index]['uId'];
                                                signOutShowDialog(context);
                                              },
                                              child: const Text(
                                                '탈퇴',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                        },
                        itemCount: data.length - uQuitCount,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '탈퇴자 명단',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Divider(),
                  Row(
                    children: const [
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 175,
                        child: Text(
                          'ID/Email',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 75,
                        child: Text(
                          '이름',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: 50,
                        child: Text(
                          '기능',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: uQuitCount * 45 -
                          MediaQuery.of(context).viewInsets.bottom,
                      // 키보드 올라오는 공간 고려
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return data.isEmpty
                              ? const Text('데이터가 없습니다.')
                              : data[index]['uQuit'] == 1
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    AdminCustomerService(
                                                        uId: data[index]
                                                            ['uId']))));
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            child: Card(
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 175,
                                                    child: Text(
                                                      data[index]['uId'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 75,
                                                    child: Text(
                                                      data[index]['uName'],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blueGrey),
                                              ),
                                              onPressed: () {
                                                uId = data[index]['uId'];
                                                signOutShowDialog(context);
                                              },
                                              child: const Text(
                                                '탈퇴',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                        },
                        itemCount: uQuitCount,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Functions
  Future getJSONData() async {
    uQuitCount = 0;
    // 비동기 방식 async : 동시에 실행되고
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/customer_list_select.jsp?search=$search');
    var response = await http.get(url);
    // await, build가 data를 기다림
    // get 방식
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // body 자체로는 decode하지 못한다 : bodyBytes
    List result = dataConvertedJSON['results'];
    setState(() {
      data = []; // 초기화 안하면 계속 누적되어서 출력된다.
      data.addAll(result);
      // 탈퇴자 수 세기
      for (int i = 0; i < data.length; i++) {
        if (data[i]['uQuit'] == 1) {
          uQuitCount++;
        }
      }
    });
  }

  signOutShowDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원 탈퇴'),
            content: const Text('정말로 탈퇴하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  signOutAction();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Customer_list');
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

  signOutAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/admin_sign_out_update.jsp?uId?$uId');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      String result = dataConvertedJSON['result'];
      if (result == 'OK') {
        Navigator.pop(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('문제가 발생 하였습니다.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }
}