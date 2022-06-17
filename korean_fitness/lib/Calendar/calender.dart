import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:korean_fitness/Calendar/calender_analysis.dart';
import 'package:korean_fitness/Calendar/calender_write.dart';
import 'package:korean_fitness/message.dart';
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
  late List allDatedata;
  late List data;
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
    data = [];
    allDatedata = [];
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 75,
            ),
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
              },

              selectedDayPredicate: (DateTime day) {
                return isSameDay(selectedDay, day);
              },

              eventLoader: (day) {
                List dot = [];
                for (int i = 0; i < allDatedata.length; i++) {
                  if (allDatedata.isEmpty) {
                  } else if (day.toString().substring(0, 10) ==
                      allDatedata[i]['cDate']) {
                    dot.add(true);
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

            const SizedBox(
              height: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(19.0),
                      //
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CalenderWrite(
                                          selectedDay: selectedDay)))
                              .then((value) => getJSONData());
                        },
                        child: Container(
                          width: 170,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(165, 81, 9, 164),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 1, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                Icons.add,
                                color: Color.fromARGB(255, 241, 228, 255),
                                size: 25
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '운동 기록 추가',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 241, 228, 255)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //
                      child: GestureDetector(
                        onTap:() {
                           Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PageViewDemo1(
                                          selectedDay: selectedDay)))
                              .then((value) => getJSONData());
                        },
                        child: Container(
                          width: 170,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(144, 0, 58, 158),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), //color of shadow
                                spreadRadius: 1, //spread radius
                                blurRadius: 1, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                '분석 결과',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 237, 237, 255)
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            data.isEmpty
                ? const Text('데이터가 없습니다')
                : SizedBox(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
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
                                        cFlexibility: data[index]
                                                ['cFlexibility']
                                            .toString(),
                                        cEndurance: data[index]['cEndurance']
                                            .toString(),
                                        cWits: data[index]['cWits'].toString(),
                                        cMuscularStrength: data[index]
                                                ['cMuscularStrength']
                                            .toString(),
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
                                child: Container(
                                  width: 370,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color.fromARGB(
                                        80, 224, 197, 255),
                                  ),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            17, 13, 0, 7),
                                        child: Text(
                                          data[index]['cTitle'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            data[index]['cFlexibility'] == 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                                .fromARGB(
                                                            129, 245, 183, 183),
                                                      ),
                                                      width: 60,
                                                      height: 30,
                                                      child: const Center(
                                                          child: Text('유연성')),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            data[index]['cEndurance'] == 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                                .fromARGB(
                                                            129, 240, 183, 245),
                                                      ),
                                                      width: 60,
                                                      height: 30,
                                                      child: const Center(
                                                          child: Text('근지구력')),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            data[index]['cWits'] == 1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color.fromARGB(129, 227, 217, 142),
                                                      ),
                                                      width: 60,
                                                      height: 30,
                                                      child: const Center(
                                                          child: Text('순발력')),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            data[index]['cMuscularStrength'] ==
                                                    1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(80, 116, 252, 195),
                                                      ),
                                                      width: 50,
                                                      height: 30,
                                                      child: const Center(
                                                          child: Text('근력')),
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            data[index]['cCardiovascularEndurance'] ==
                                                    1
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                                .fromARGB(
                                                            98, 116, 154, 252),
                                                      ),
                                                      width: 90,
                                                      height: 30,
                                                      child: const Center(
                                                          child: Text('심폐지구력')),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            17, 0, 0, 0),
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
                            ],
                          );
                        }),
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
      //키값
      List value = dataConvertedJSON['results'];
      //데이터에 넣기
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
      //키값
      List value = dataConvertedJSON['results'];
      // List value = dataConvertedJSON['results'];
      //데이터에 넣기
      allDatedata.addAll(value);
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
            title: const Text('삭제'),
            content: const Text('정말로 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('아니오'),
              ),
              TextButton(
                onPressed: () {
                  deleteAction();
                },
                child: const Text('예'),
              ),
            ],
          );
        });
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('결과'),
            content: const Text('삭제가 완료되었습니다'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 삭제에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }

  category() {
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(129, 183, 191, 245),
      ),
      width: 70,
      height: 30,
    );
  }
}
