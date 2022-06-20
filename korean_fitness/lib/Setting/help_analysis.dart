import 'package:flutter/material.dart';

class Help_Analysis extends StatefulWidget {
  const Help_Analysis({Key? key}) : super(key: key);

  @override
  State<Help_Analysis> createState() => Help_AnalysisState();
}

class Help_AnalysisState extends State<Help_Analysis> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: const [
        AnalysisGuide1(),
        AnalysisGuide2(),
        AnalysisGuide3(),
        AnalysisGuide4(),
      ],
    );
  }
}

class AnalysisGuide1 extends StatefulWidget {
  const AnalysisGuide1({Key? key}) : super(key: key);

  @override
  State<AnalysisGuide1> createState() => AnalysisGuide1State();
}

class AnalysisGuide1State extends State<AnalysisGuide1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "분석 가이드",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Color.fromARGB(255, 85, 65, 172),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Image.asset(
          "images/analysis1.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AnalysisGuide2 extends StatefulWidget {
  const AnalysisGuide2({Key? key}) : super(key: key);

  @override
  State<AnalysisGuide2> createState() => AnalysisGuide2State();
}

class AnalysisGuide2State extends State<AnalysisGuide2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "분석 가이드",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Color.fromARGB(255, 85, 65, 172),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Image.asset(
          "images/analysis2.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AnalysisGuide3 extends StatefulWidget {
  const AnalysisGuide3({Key? key}) : super(key: key);

  @override
  State<AnalysisGuide3> createState() => AnalysisGuide3State();
}

class AnalysisGuide3State extends State<AnalysisGuide3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "분석 가이드",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Color.fromARGB(255, 85, 65, 172),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Image.asset(
          "images/analysis3.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AnalysisGuide4 extends StatefulWidget {
  const AnalysisGuide4({Key? key}) : super(key: key);

  @override
  State<AnalysisGuide4> createState() => AnalysisGuide4State();
}

class AnalysisGuide4State extends State<AnalysisGuide4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "분석 가이드",
          style: TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: Color.fromARGB(255, 85, 65, 172),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: Center(
        child: Image.asset(
          "images/analysis4.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}