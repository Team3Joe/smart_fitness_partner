import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class CalenderModifyDelete extends StatefulWidget {
  final String cTitle;
  final String cContent;
  final String cFlexibility;
  final String cEndurance;
  final String cWits;
  final String cMuscularStrength;
  final String cCardiovascularEndurance;
  final String cDate;
  final DateTime selectedDay;
  final String cCode;
  const CalenderModifyDelete(
      {Key? key,
      required this.cTitle,
      required this.cContent,
      required this.cFlexibility,
      required this.cEndurance,
      required this.cWits,
      required this.cMuscularStrength,
      required this.cCardiovascularEndurance,
      required this.cDate,
      required this.selectedDay,
      required this.cCode,})
      : super(key: key);

  @override
  State<CalenderModifyDelete> createState() => _CalenderModifyDeleteState();
}

class _CalenderModifyDeleteState extends State<CalenderModifyDelete> {
  //property
  late TextEditingController cTitleController;
  late TextEditingController cContentController;

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
  late String result;

  // button state
  late String _cFlexibilityState;
  late String _cEnduranceState;
  late String _cWitsState;
  late String _cMuscularStrengthState;
  late String _cCardiovascularEnduranceState;

  // button colors
  late Color _cFlexibilityColors;
  late Color _cEnduranceColors;
  late Color _cWitsColors;
  late Color _cMuscularStrengthColors;
  late Color _cCardiovascularEnduranceColors;

  @override
  void initState() {
    super.initState();
    cCode = widget.cCode;
    cTitleController = TextEditingController();
    cContentController = TextEditingController();

    cTitleController.text = widget.cTitle;
    cContentController.text = widget.cContent;

    _cFlexibilityState = widget.cFlexibility;
    _cEnduranceState = widget.cEndurance;
    _cWitsState = widget.cWits;
    _cMuscularStrengthState = widget.cMuscularStrength;
    _cCardiovascularEnduranceState = widget.cCardiovascularEndurance;

    // button Colors
    if (_cFlexibilityState == '1') {
      _cFlexibilityColors = Color.fromARGB(129, 245, 183, 183);
    } else {
      _cFlexibilityColors = Colors.grey.shade200;
    }
    if (_cEnduranceState == '1') {
      _cEnduranceColors = Color.fromARGB(129, 240, 183, 245);
    } else {
      _cEnduranceColors = Colors.grey.shade200;
    }
    if (_cWitsState == '1') {
      _cWitsColors = Color.fromARGB(129, 183, 191, 245);
    } else {
      _cWitsColors = Colors.grey.shade200;
    }
    if (_cMuscularStrengthState == '1') {
      _cMuscularStrengthColors = Color.fromARGB(98, 116, 154, 252);
    } else {
      _cMuscularStrengthColors = Colors.grey.shade200;
    }
    if (_cCardiovascularEnduranceState == '1') {
      _cCardiovascularEnduranceColors = Color.fromARGB(129, 245, 238, 183);
    } else {
      _cCardiovascularEnduranceColors = Colors.grey.shade200;
    }
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
          '오늘의 운동',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
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
              cDate = widget.selectedDay.toString().substring(0, 10);
              cCode = widget.cCode;
              updateAction();
            },
            child: const Text(
              '수정',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
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
                    child: Text('유연성'),
                    onPressed: () {
                      setState(() {
                        if (_cFlexibilityColors == Colors.grey.shade200) {
                          _cFlexibilityColors =
                              Color.fromARGB(129, 245, 183, 183);
                          _cFlexibilityState = '1';
                        } else {
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
                    child: Text('근지구력'),
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
                    child: Text('순발력'),
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
                    child: Text('근력'),
                    onPressed: () {
                      setState(() {
                        if (_cMuscularStrengthColors == Colors.grey.shade200) {
                          _cMuscularStrengthColors =
                              Color.fromARGB(98, 116, 154, 252);
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
                    child: Text('심폐지구력'),
                    onPressed: () {
                      setState(() {
                        if (_cCardiovascularEnduranceColors ==
                            Colors.grey.shade200) {
                          _cCardiovascularEnduranceColors =
                              Color.fromARGB(129, 245, 238, 183);
                          _cCardiovascularEnduranceState = '1';
                        } else {
                          _cCardiovascularEnduranceColors =
                              Colors.grey.shade200;
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
              const Text(
                '운동 메모 :',
              ),
              const SizedBox(
                height: 20,
              ),
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
    );
  }

 //functions

//updateAction
 updateAction() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/calendar_modify.jsp?cTitle=$cTitle&cContent=$cContent&cFlexibility=$cFlexibility&cEndurance=$cEndurance&cWits=$cWits&cMuscularStrength=$cMuscularStrength&cCardiovascularEndurance=$cCardiovascularEndurance&cCode=$cCode');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
        Navigator.pop(context);
      } else {
        errorSnackBar(context);
      }
    });
    
  }

//errorSnackBar
errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 삭제에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ),
    );
  }


}
