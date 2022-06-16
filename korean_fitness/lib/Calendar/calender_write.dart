import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CalenderWrite extends StatefulWidget {
  // final Map<DateTime, List<Event>> selectedEvents;
  final DateTime selectedDay;

  const CalenderWrite({Key? key,required this.selectedDay}) : super(key: key);

  @override
  State<CalenderWrite> createState() => _CalenderWriteState();
}

class _CalenderWriteState extends State<CalenderWrite> {
  // property
  late TextEditingController cTitleController;
  late TextEditingController cContentController;

  // button name
  late String _cFlexibilityName;
  late String _cEnduranceName;
  late String _cWitsName;
  late String _cMuscularStrengthName;
  late String _cCardiovascularEnduranceName;

  // button state
  late String _cFlexibilityState;
  late String _cEnduranceState;
  late String _cWitsState;
  late String _cMuscularStrengthState;
  late String _cCardiovascularEnduranceState;

  // button color
  late Color _cFlexibilityColors;
  late Color _cEnduranceColors;
  late Color _cWitsColors;
  late Color _cMuscularStrengthColors;
  late Color _cCardiovascularEnduranceColors;

  //sql
  late String cTitle;
  late String cContent;
  late String cFlexibility;
  late String cEndurance;
  late String cWits;
  late String cMuscularStrength;
  late String cCardiovascularEndurance;
  late String cDate;
  late String result;
  late String uId;


  @override
  void initState() {
    super.initState();
    cTitleController = TextEditingController();
    cContentController = TextEditingController();

    // button name
    _cFlexibilityName = '유연성';
    _cEnduranceName = '근지구력';
    _cWitsName = '순발력';
    _cMuscularStrengthName = '근력';
    _cCardiovascularEnduranceName = '심폐지구력';

    // button state
    _cFlexibilityState = '0';
    _cEnduranceState = '0';
    _cWitsState = '0';
    _cMuscularStrengthState = '0';
    _cCardiovascularEnduranceState = '0';

    // button color
    _cFlexibilityColors = Colors.grey.shade200;
    _cEnduranceColors = Colors.grey.shade200;
    _cWitsColors = Colors.grey.shade200;
    _cMuscularStrengthColors = Colors.grey.shade200;
    _cCardiovascularEnduranceColors = Colors.grey.shade200;


  }

  @override
  void dispose() {
    cTitleController.dispose();
    cContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  아무데나 터치해도 키보드 내려가게 하기
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(168, 111, 110, 110), //색변경
          ),
          title: const Text(
            '오늘의 운동',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor:  Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                cTitle = cTitleController.text;
                cContent = cContentController.text;
                cFlexibility = _cFlexibilityState;
                cEndurance = _cEnduranceState;
                cWits = _cWitsState;
                cMuscularStrength = _cMuscularStrengthState;
                cCardiovascularEndurance = _cCardiovascularEnduranceState;
                uId = "asdf";
                cDate = widget.selectedDay.toString().substring(0,10);
                insertAction();
                
              },
              child: const Text(
                '저장',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
    
        //body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '운동 이름',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                TextField(
                  controller: cTitleController,
                ),
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  '운동 부위',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          _cFlexibilityColors,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      child: Text(_cFlexibilityName),
                      onPressed: () {
                        setState(() {
                          if(_cFlexibilityColors == Colors.grey.shade200){
                            _cFlexibilityColors = Color.fromARGB(129, 245, 183, 183);
                            _cFlexibilityState = '1';
                          }else{
                            _cFlexibilityColors = Colors.grey.shade200;
                            _cFlexibilityState = '0';
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          _cEnduranceColors,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      child: Text(_cEnduranceName),
                      onPressed: () {
                        setState(() {
                          if (_cEnduranceColors == Colors.grey.shade200) {
                            _cEnduranceColors =
                                Color.fromARGB(129, 240, 183, 245);
                                _cEnduranceState = '1';
                          } else {
                            _cEnduranceColors = Colors.grey.shade200;
                            _cEnduranceState = '0';
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          _cWitsColors,
                        ),
                        foregroundColor: MaterialStateProperty.all(
                          Colors.black,
                        ),
                      ),
                      child: Text(_cWitsName),
                      onPressed: () {
                        setState(() {
                          if (_cWitsColors == Colors.grey.shade200) {
                            _cWitsColors = Color.fromARGB(129, 183, 191, 245);
                            _cWitsState = '1';
                          } else {
                            _cWitsColors = Colors.grey.shade200;
                            _cWitsState = '0';
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _cMuscularStrengthColors,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          )),
                      child: Text(_cMuscularStrengthName),
                      onPressed: () {
                         setState(() {
                          if (_cMuscularStrengthColors == Colors.grey.shade200) {
                            _cMuscularStrengthColors = Color.fromARGB(98, 116, 154, 252);
                            _cMuscularStrengthState = '1';
                          } else {
                            _cMuscularStrengthColors = Colors.grey.shade200;
                            _cMuscularStrengthState = '0';
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _cCardiovascularEnduranceColors,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            Colors.black,
                          )),
                      child: Text(_cCardiovascularEnduranceName),
                      onPressed: () {
                        setState(() {
                          if (_cCardiovascularEnduranceColors == Colors.grey.shade200) {
                            _cCardiovascularEnduranceColors =
                                Color.fromARGB(129, 245, 238, 183);
                                _cCardiovascularEnduranceState = '1';
                          } else {
                            _cCardiovascularEnduranceColors = Colors.grey.shade200;
                            _cCardiovascularEnduranceState = '0';
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text('운동 메모 :',),
                const SizedBox(height: 20,),
                TextField(
                  controller: cContentController,
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // function
   insertAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/calendar_write.jsp?cTitle=$cTitle&cContent=$cContent&cFlexibility=$cFlexibility&cEndurance=$cEndurance&cWits=$cWits&cMuscularStrength=$cMuscularStrength&cCardiovascularEndurance=$cCardiovascularEndurance&uId=$uId&cDate=$cDate');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
      //  _showDialog(context);
        Navigator.pop(context);
      } else {
        errorSnackBar(context);
      }
    });
}

  _showDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('입력결과'),
            content: const Text('입력이 완료되었습니다'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
        content: Text('사용자 정보 입력에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }



}