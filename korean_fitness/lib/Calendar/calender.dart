import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:korean_fitness/Calendar/calender_write.dart';
import 'package:korean_fitness/Setting/mypage.dart';
import 'package:korean_fitness/message.dart';
import 'package:korean_fitness/message4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import 'calender_modify_delete.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  //property
  late String finalId;
  late String finalName;
  late String finalEmail;
  late List allDatedata;
  late List data;
  late List analysisData;
  late List allAnalysisData;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late String result;

  //sql
  late String cTitle;
  late String cContent;
  late String cFlexibility;
  late String cEndurance;
  late String cWits;
  late String cMuscularStrength;
  late String cCardiovascularEndurance;
  late String cDate;
  late String uId;
  late String cCode;
  int i = 0;

  @override
  void initState() {
    super.initState();
    finalId = "";
    finalName = "";
    finalEmail = "";
    data = [];
    allDatedata = [];
    analysisData = [];
    allAnalysisData = [];
    cDate = DateTime.now().toString().substring(0, 10);
    cCode = '';
    cTitle = '';
    cContent = '';
    cFlexibility = '';
    cEndurance = '';
    cWits = '';
    cMuscularStrength = '';
    cCardiovascularEndurance = '';
    uId = Message.uId;
    getJSONData();
    getAnalysisData();
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //calendar
            TableCalendar(
              locale: 'ko-KR',
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              focusedDay: selectedDay,
              calendarFormat: _calendarFormat,
              onFormatChanged: (CalendarFormat format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
      
              // Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay; // update `_focusedDay` here as well
                  cDate = selectedDay.toString().substring(0, 10);
                });
                getJSONData();
                getAnalysisData();
              },
      
              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDay, day);
              },
      
              eventLoader: (day) {
                List dot = [];
      
                for (int i = 0; i < allDatedata.length; i++) {
                  if (allDatedata.isNotEmpty) {
                    if (day.toString().substring(0, 10) ==
                        allDatedata[i]['cDate']) {
                      dot.add(true);
                    }
                  }
                }
                for (int a = 0; a < allAnalysisData.length; a++) {
                  if (allAnalysisData.isNotEmpty) {
                    if (day.toString().substring(0, 10) ==
                        allAnalysisData[a]['bDate']) {
                      dot.add(true);
                    }
                  }
                }
                return dot;
              },
              // Calendar Style
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                ),
                todayDecoration: const BoxDecoration(
                  color: Color.fromARGB(178, 186, 104, 200),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonShowsNext: false,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CalenderWrite(selectedDay: selectedDay)))
                            .then((value) => getJSONData());
                      },
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(165, 81, 9, 164),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 1, // blur radius
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                            //you can set more BoxShadow() here
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add,
                                color: Color.fromARGB(255, 241, 228, 255),
                                size: 25),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '?????? ?????? ??????',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 241, 228, 255)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    
                    GestureDetector(
                      // ?????? ?????? ?????? ?????? tap ?????? ????????? ?????? ???????????? ????????????
                      // ???????????? ???????????? ???????????? analysisDataCheck(); ??? ??????
                      onTap: () {
                        Message4.selectedDay =
                            selectedDay.toString().substring(0, 10);
                        analysisDataCheck();
                      },
                      child: Container(
                        width: 150,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(144, 0, 58, 158),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 1, // blur radius
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                            //you can set more BoxShadow() here
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.bar_chart,
                              color: Color.fromARGB(255, 237, 237, 255),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '?????? ?????? ??????',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 237, 237, 255)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 220, 
              child: data.isEmpty
                  ? const Text('???????????? ????????????')
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          //calenderDelete
                          onLongPress: () {
                            cCode = data[index]['cCode'].toString();
                            deleteShowDialog(context);
                          },
                          //calendarModify
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CalenderModifyDelete(
                                  cTitle: data[index]['cTitle'],
                                  cContent: data[index]['cContent'],
                                  cFlexibility:
                                      data[index]['cFlexibility'].toString(),
                                  cEndurance:
                                      data[index]['cEndurance'].toString(),
                                  cWits: data[index]['cWits'].toString(),
                                  cMuscularStrength:
                                      data[index]['cMuscularStrength'].toString(),
                                  cCardiovascularEndurance: data[index]
                                          ['cCardiovascularEndurance']
                                      .toString(),
                                  cDate: data[index]['cDate'],
                                  selectedDay: selectedDay,
                                  cCode: data[index]['cCode'].toString(),
                                ),
                              ),
                            ).then((value) => getJSONData());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 200,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(80, 224, 197, 255),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(17, 13, 0, 7),
                                    child: Text(
                                      data[index]['cTitle'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        data[index]['cFlexibility'] == 1
                                            ? Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: const Color.fromARGB(
                                                        129, 245, 183, 183),
                                                  ),
                                                  width: 60,
                                                  height: 30,
                                                  child: const Center(
                                                      child: Text('?????????')),
                                                ),
                                              )
                                            : const SizedBox(),
                                        data[index]['cEndurance'] == 1
                                            ? Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: const Color.fromARGB(
                                                        129, 240, 183, 245),
                                                  ),
                                                  width: 60,
                                                  height: 30,
                                                  child: const Center(
                                                      child: Text('????????????')),
                                                ),
                                              )
                                            : const SizedBox(),
                                        data[index]['cWits'] == 1
                                            ? Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: const Color.fromARGB(
                                                        129, 227, 217, 142),
                                                  ),
                                                  width: 60,
                                                  height: 30,
                                                  child: const Center(
                                                      child: Text('?????????')),
                                                ),
                                              )
                                            : const SizedBox(),
                                        data[index]['cMuscularStrength'] == 1
                                            ? Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: const Color.fromARGB(
                                                        80, 116, 252, 195),
                                                  ),
                                                  width: 50,
                                                  height: 30,
                                                  child: const Center(
                                                      child: Text('??????')),
                                                ),
                                              )
                                            : const SizedBox(),
                                        data[index]['cCardiovascularEndurance'] == 1
                                            ? Padding(
                                                padding: const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    color: const Color.fromARGB(
                                                        98, 116, 154, 252),
                                                  ),
                                                  width: 90,
                                                  height: 30,
                                                  child: const Center(
                                                      child: Text('???????????????')),
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(17, 0, 0, 0),
                                    child: Text(
                                      data[index]['cContent'],
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          //?????? ?????? ??? ?????????
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              //????????? ????????? ??????
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/korea.png'),
              ),
              //????????? ?????? ?????? & ?????????
              accountName: Text('${Message.uName}???'),
              accountEmail: Text(Message.uEmail),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 164, 154, 239),
                //?????????, ?????? ?????? ??? ??? ??????. all ??? ????????? ??? ???
              ),
            ),
            // ?????????
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
              title: const Text('??????'),
            ),
            ListTile(
              onTap: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove("id");
                handleSignOut();
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, '/Log_in');
              },
              leading: const Icon(
                Icons.logout,
                // color: Colors.deepPurple,
              ),
              title: const Text('????????????'),
            ),
          ],
        ),
      ),
    );
  }

  // function
  Future getJSONData() async {
    data.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/calendar_select.jsp?uId=$uId&cDate=$cDate");
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      //??????
      List value = dataConvertedJSON['results'];
      //???????????? ??????
      data.addAll(value);
    });
    getJSONDataAllDate();
  }

  Future getJSONDataAllDate() async {
    allDatedata.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/calendar_allDateSelect.jsp?uId=$uId");
    var respons = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(respons.bodyBytes));
      //??????
      List value = dataConvertedJSON['results'];
      // List value = dataConvertedJSON['results'];
      //???????????? ??????
      allDatedata.addAll(value);
    });
  }

  Future getAnalysisData() async {
    analysisData.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/calendar_analysis_select.jsp?uId=$uId&bDate=$cDate");
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      //??????
      List value = dataConvertedJSON['results'];
      //???????????? ??????
      analysisData.addAll(value);
      getAnalysisDataAllDate();
    });
  }

  Future getAnalysisDataAllDate() async {
    allAnalysisData.clear();
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/calendar_analysis_all.jsp?uId=$uId");
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      //??????
      List value = dataConvertedJSON['results'];
      //???????????? ??????
      allAnalysisData.addAll(value);
    });
  }

  deleteAction() async {
    var url = Uri.parse(
        "http://localhost:8080/Flutter/fitness/calendar_delete.jsp?cCode=$cCode");
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
        getJSONData();
        Navigator.pop(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  deleteShowDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('??????'),
            content: const Text('????????? ?????????????????????????'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('?????????'),
              ),
              TextButton(
                onPressed: () {
                  deleteAction();
                },
                child: const Text('???'),
              ),
            ],
          );
        });
  }

  snackBarFuntion(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('??????????????? ???????????? ????????????!'),
        //???????????? ????????? ????????? ??????
        duration: Duration(seconds: 1),
        backgroundColor: Color.fromARGB(255, 179, 13, 129),
      ),
    );
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('????????? ?????? ????????? ????????? ?????????????????????.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  category() {
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(129, 183, 191, 245),
      ),
      width: 70,
      height: 30,
    );
  }

  analysisDataCheck() {
    if (analysisData.isNotEmpty) {
      Navigator.pushNamed(context, '/Calender_alnalysis');
    } else {
      snackBarFuntion(context);
    }
  }

  Future<void> handleSignOut() => googleSignIn.disconnect();

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
  }
}
