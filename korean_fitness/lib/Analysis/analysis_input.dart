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
          title: Text('나의 신체 티어는?'),
          backgroundColor: Color.fromARGB(255, 209, 149, 233),
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
                    style: TextStyle(
                      color: Color.fromARGB(200, 209, 149, 233)
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Center_list');
                        },
                        style: OutlinedButton.styleFrom(
                          primary: Color.fromARGB(255, 145, 108, 255),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 145, 108, 255),
                            width: 1.5,
                          ),
                        ),
                        child: const Text('우리집 근처 체력측정센터',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 234, 200, 247)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 234, 200, 247)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 234, 200, 247)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
                    child: TextField(
                      controller: ageController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
                    child: TextField(
                      controller: gripController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
                    child: TextField(
                      controller: forwardBendingController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 195, 180, 250)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
                    child: TextField(
                      controller: longJumpController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,8),
                    child: TextField(
                      controller: fatMassController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
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
                    padding: const EdgeInsets.fromLTRB(40,8,40,30),
                    child: TextField(
                      controller: situpController,
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
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 133, 165, 253)),
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
                    gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 133, 165, 253),
                          Color.fromARGB(255, 150, 126, 255)
                          //add more colors
                        ]
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                      ]
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        //make color or elevated button transparent
                      ),
                      onPressed: (){
                              Message2.height = heightController.text;
                              Message2.weight = weightController.text;
                              Message2.age = ageController.text;
                              Message2.grip = gripController.text;
                              Message2.forwardBending = forwardBendingController.text;
                              Message2.longJump = longJumpController.text;
                              Message2.fatMass = fatMassController.text;
                              Message2.situp = situpController.text;
          
                              Navigator.pushNamed(context, '/Analysis_result');
                      },
                      label: const Text(
                        "티어분석",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward,
                        size : 20,
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

    // insertAction() async{
    // var url = Uri.parse(
    //   'http://localhost:8080/Flutter/student_insert_return_flutter.jsp?code=$code&name=$name&dept=$dept&phone=$phone'
    // );
    // var response = await http.get(url);
    // setState(() {
    //   var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    //   result = dataConvertedJSON['result'];
    // });
    // if(result == 'OK'){
    //   _showDialog(context);
    // }else{
    //   errorSnackBar(context);
    // }
    // }
  }
}
