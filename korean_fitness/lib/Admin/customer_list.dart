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
  late List data;

  @override
  void initState() {
    super.initState();
    searchField = TextEditingController();
    search = '';
    data = [];
    getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('고객 명단'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 180,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 600 - MediaQuery.of(context).viewInsets.bottom,
                // 키보드 올라오는 공간 고려
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AdminCustomerService(
                                    uId: data[index]['uId']))));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                data[index]['uId'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                data[index]['uName'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                data[index]['uEmail'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
                  width: 200,
                  child: TextField(
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
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
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
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                    onPressed: () {
                      setState(() {
                        search = '';
                        getJSONData();
                      });
                    },
                    child: const Text('초기화')),
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
    });
  }

  // insertAction() async {
  //   var url = Uri.parse(
  //     'http://localhost:8080/Flutter/fitness/customer_service_insert.jsp?csContent=$csContent&uId=abc',
  //   );
  //   var response = await http.get(url);
  //   setState(
  //     () {
  //       var dataConvertedJSON = json.decode(
  //         utf8.decode(response.bodyBytes),
  //       );
  //       String result = dataConvertedJSON['result'];

  //       if (result == 'OK') {
  //         _showDialog(context);
  //         Navigator.pop(context);
  //       } else {
  //         _errorSnackBar(context);
  //       }
  //     },
  //   );
  // }

  // _showDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('입력 결과'),
  //         content: const Text('입력이 완료되었습니다.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _errorSnackBar(BuildContext context) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       content: Text('사용자 정보 입력에 문제가 발생했습니다.'),
  //       duration: Duration(seconds: 1),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }
}
