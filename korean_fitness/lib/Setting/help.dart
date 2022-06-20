import 'package:flutter/material.dart';
import 'package:korean_fitness/Setting/help_analysis.dart';
import 'package:korean_fitness/Setting/help_calendar.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '도움말 & 사용설명서',
          style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 23,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(3, 3),
                    blurRadius:10
                  )
                ]
              ),
          ),
        backgroundColor: const Color.fromARGB(198, 58, 34, 131),
        toolbarHeight: 75,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
                  height: 30,
                ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const Help_Analysis()));
              },
              child: SizedBox(
                width: 350,
                height: 70,
                child: Card(
                  color: const Color.fromARGB(134, 182, 167, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          size: 13,
                          // color: Color.fromARGB(186, 30, 22, 56),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '분석결과는 어떻게 보는 걸까요?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            //color: Color.fromARGB(174, 17, 1, 65),
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Help_Calendar()));
              },
              child: SizedBox(
                width: 350,
                height: 70,
                child: Card(
                  color: const Color.fromARGB(134, 182, 167, 239),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.circle,
                          size: 13,
                          // color: Color.fromARGB(186, 30, 22, 56),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '캘린더 입력은 어떻게 하는 건가요?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            //color: Color.fromARGB(174, 17, 1, 65),
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}