import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:korean_fitness/message2.dart';

class AnalysisData extends StatefulWidget {
  const AnalysisData({Key? key}) : super(key: key);

  @override
  State<AnalysisData> createState() => _AnalysisDataState();
}

class _AnalysisDataState extends State<AnalysisData> {
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController ageController;
  late TextEditingController gripController;
  late TextEditingController forwardBendingController;
  late TextEditingController longJumpController;
  late TextEditingController fatMassController;
  late TextEditingController situpController;

  late String height;
  late String weight;
  late String age;
  late String grip;
  late String forwardBending;
  late String longJump;
  late String fatMass;
  late String situp;
  late String bmr;
  late String bmi;

  late String ratingUri;

  late String ratingResult;
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();

    heightController = TextEditingController();
    weightController = TextEditingController();
    ageController = TextEditingController();
    gripController = TextEditingController();
    forwardBendingController = TextEditingController();
    longJumpController = TextEditingController();
    fatMassController = TextEditingController();
    situpController = TextEditingController();

    height = "";
    weight = "";
    age = "";
    grip = "";
    forwardBending = "";
    longJump = "";
    fatMass = "";
    situp = "";

    ratingUri = "";

    bmr = "";
    bmi = "";
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
          title: Text(
              '나의 신체 티어는?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(5, 5),
                    blurRadius:10
                  )
                ]
              ),
            ),
          backgroundColor: Color.fromARGB(255, 197, 129, 224),
          elevation: 0,
          toolbarHeight: 75,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "                                    좀더 정확한 분석을 위해\n                             체력측정센터를 방문해보세요!",
                    style: TextStyle(color: Color.fromARGB(200, 209, 149, 233)),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      // OutlinedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, '/Center_list');
                      //   },
                      //   style: OutlinedButton.styleFrom(
                      //     primary: Color.fromARGB(255, 145, 108, 255),
                      //     side: const BorderSide(
                      //       color: Color.fromARGB(255, 145, 108, 255),
                      //       width: 1.5,
                      //     ),
                      //   ),
                      //   child: const Text('우리집 근처 체력측정센터',
                      //       style: TextStyle(fontSize: 18)),
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          
                          Navigator.pushNamed(context, '/Center_list');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(189, 145, 108, 255),
                        ),
                        child: const Text(
                          '우리집 근처 체력측정센터',
                          style: TextStyle(fontSize: 18)
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: weightController,
                      decoration: const InputDecoration(
                        labelText: '몸무게(Weight)',
                        hintText: '몸무게를 입력해주세요(Enter your Weight)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 203, 144, 226),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 203, 144, 226),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 189, 130, 212),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: heightController,
                      decoration: const InputDecoration(
                        labelText: '키(Height)',
                        hintText: '키를 입력해주세요(Enter your Height)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 203, 144, 226),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 203, 144, 226),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 189, 130, 212),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: situpController,
                      decoration: const InputDecoration(
                        labelText: '윗몸 일으키기(Sit-up)',
                        hintText: '윗몸 일으키기 갯수를 입력해주세요',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 145, 108, 255),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 145, 108, 255),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 112, 89, 192),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: ageController,
                      decoration: const InputDecoration(
                        labelText: '나이(Height)',
                        hintText: '나이를 입력해주세요(Enter your age)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 145, 108, 255),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 145, 108, 255),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 112, 89, 192),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: gripController,
                      decoration: const InputDecoration(
                        labelText: '악력(grip)',
                        hintText: '악력을 입력해주세요(Enter your grip)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 145, 108, 255),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 145, 108, 255),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 112, 89, 192),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: forwardBendingController,
                      decoration: const InputDecoration(
                        labelText: '앞으로 구부리기(forwardBending)',
                        hintText: '앞으로 구부리기(cm) 값을 입력해주세요',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 91, 126, 222),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 76, 111, 208),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 76, 111, 208),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    child: TextField(
                      controller: longJumpController,
                      decoration: const InputDecoration(
                        labelText: '멀리뛰기(longJump)',
                        hintText: '멀리뛰기(cm)을 입력해주세요(Enter your longJump)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 91, 126, 222),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 91, 126, 222),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 76, 111, 208),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 8, 40, 20),
                    child: TextField(
                      controller: fatMassController,
                      decoration: const InputDecoration(
                        labelText: '체지방량(fatMass)',
                        hintText: '체지방량을 입력해주세요(Enter your fatmass)',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 91, 126, 222),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromARGB(150, 91, 126, 222),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      cursorColor: const Color.fromARGB(255, 76, 111, 208),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 133, 165, 253),
                          Color.fromARGB(255, 150, 126, 255)
                          //add more colors
                        ]),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        //make color or elevated button transparent
                      ),
                      onPressed: () {
                        Message2.height = heightController.text;
                        Message2.weight = weightController.text;
                        Message2.age = ageController.text;
                        Message2.grip = gripController.text;
                        Message2.forwardBending = forwardBendingController.text;
                        Message2.longJump = longJumpController.text;
                        Message2.fatMass = fatMassController.text;
                        Message2.situp = situpController.text;

                        height = heightController.text;
                        weight = weightController.text;
                        age = ageController.text;
                        grip = gripController.text;
                        forwardBending = forwardBendingController.text;
                        longJump = longJumpController.text;
                        fatMass = fatMassController.text;
                        situp = situpController.text;

                        
                        getRatingResult();
                      },
                      label: const Text(
                        "티어분석",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  analysis() async{
    if (heightController.text.isEmpty == false &&
        weightController.text.isEmpty == false &&
        ageController.text.isEmpty == false &&
        gripController.text.isEmpty == false &&
        gripController.text.isEmpty == false &&
        forwardBendingController.text.isEmpty == false &&
        longJumpController.text.isEmpty == false &&
        fatMassController.text.isEmpty == false &&
        situpController.text.isEmpty == false) {
      height = heightController.text;
      weight = weightController.text;
      age = ageController.text;
      grip = gripController.text;
      forwardBending = forwardBendingController.text;
      longJump = longJumpController.text;
      fatMass = fatMassController.text;
      situp = situpController.text;

      double double_weight = double.parse(weight);
      double double_height = double.parse(height);
      double double_grip = double.parse(grip);
      double double_forwardBending = double.parse(forwardBending);
      int int_age = int.parse(age);
      double double_longJump = double.parse(longJump);
      double double_fatMass = double.parse(fatMass);
      double double_situp = double.parse(situp);

      if (double_weight > 250) {
        errorSnackBar(context);
      } else if (double_height >= 250) {
        errorSnackBar2(context);
      } else if (double_situp > 200) {
        errorSnackBar3(context);
      } else if (int_age > 200) {
        errorSnackBar4(context);
      } else if (double_grip > 200) {
        errorSnackBar5(context);
      } else if (double_forwardBending > 150 && double_forwardBending < -100) {
        errorSnackBar6(context);
      } else if (double_longJump > 300 && double_longJump < 0) {
        errorSnackBar7(context);
      } else if (double_fatMass > 100) {
        errorSnackBar8(context);
      } else {
        Message2.height = height;
        Message2.weight = weight;
        Message2.age = age;
        Message2.grip = grip;
        Message2.forwardBending = forwardBending;
        Message2.longJump = longJump;
        Message2.fatMass = fatMass;
        Message2.situp = situp;
        await Navigator.pushNamed(context, '/Analysis_result');
      }
    } else {
      errorSnackBar9(context);
    }
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("몸무게 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar2(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("키 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar3(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("윗몸 일으키기 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar4(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("나이 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar5(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("악력 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar6(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("앞으로 구부리기 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar7(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("멀리뛰기 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar8(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("체지방량 입력을 잘못되었습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  errorSnackBar9(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("모든 값을 입력해주세요."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  getRatingResult() async {

    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Color.fromARGB(148, 0, 0, 0),
          body: Center(
            child: SizedBox(
              width: 180,
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: const [
                  CircularProgressIndicator(
                    strokeWidth: 12,
                    backgroundColor: Colors.white,
                    color: Color.fromARGB(255, 107, 47, 176),
                  ),
                  Center(
                      child: Text(
                    '\tSmart\nFitness\n\t\tTest',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight : FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );

    print(Message2.gender);



    //비동기 함수 == 작업하면서 화면구성도 같이하겠다!
    //이럴땐 (주소) var를 많이 씀.
    // result.clear();

    var bmi2 = double.parse(weightController.text) /
        ((double.parse(heightController.text) / 100) *
            (double.parse(heightController.text) / 100));
    bmi = bmi2.toString();
    Message2.bmi = bmi;

    // 여자 bmr 계산법
    if (Message2.gender == "여") {
      var bmr2 = 655.1 +
          (9.56 * double.parse(weightController.text)) +
          (1.85 * double.parse(heightController.text)) -
          4.68 * int.parse(ageController.text);
      bmr = bmr2.toString();
      Message2.bmr = bmr;
      ratingUri =
          "http://localhost:8080/Rserve/response_bodyF.jsp?age=$age&fatMass=$fatMass&grip=$grip&forwardBending=$forwardBending&situp=$situp&longJump=$longJump&bmi=$bmi&bmr=$bmr";
      print(ratingUri);
    } else {
      // 남자 bmr 계산법
      int ageGroup2 = (int.parse(ageController.text) ~/ 4) - 3;
      String ageGroup = ageGroup2.toString();

      var bmr2 = 66.47 +
          (13.75 * double.parse(weightController.text)) +
          (5 * double.parse(heightController.text)) -
          (6.76 * int.parse(ageController.text));
      bmr = bmr2.toString();
      Message2.bmr = bmr;
      ratingUri =
          "http://localhost:8080/Rserve/response_mbp.jsp?age=$age&fatMass=$fatMass&grip=$grip&forwardBending=$forwardBending&situp=$situp&longJump=$longJump&bmi=$bmi&bmr=$bmr&ageGroup=$ageGroup";
    }

    var url = Uri.parse(ratingUri);
    //http 가 위주소를 다가져옴 //await <- 빌드가 끝날때까지 일단 기다려
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      ratingResult = dataConvertedJSON['result']; //results 키값!

      print(ratingResult);

      Message2.ratingResult = ratingResult;

      //result[0]['code'] = S001 <- 리스트에 넣어준거 불러오는법
    });

    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/Analysis_result');
    });


  }
}
