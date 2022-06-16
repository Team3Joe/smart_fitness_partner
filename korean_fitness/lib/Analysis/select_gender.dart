import 'package:flutter/material.dart';
import 'package:korean_fitness/Analysis/analysis_input.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key}) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
          "성별을 선택해주세요",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 20, 0, 48)
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnalysisData())
                  );
                },
                child: Column(
                  children: [
                    const Text(
                      "남성",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 48, 8, 103),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "images/man.png",
                      width: 170,
                      height: 170,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnalysisData())
                  );
                },
                child: Column(
                  children: [
                    const Text(
                      "여성",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 48, 8, 103),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "images/woman.png",
                      width: 170,
                      height: 170,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}