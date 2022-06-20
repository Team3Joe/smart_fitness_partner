import 'package:flutter/material.dart';

class Help_Calendar extends StatefulWidget {
  const Help_Calendar({Key? key}) : super(key: key);

  @override
  State<Help_Calendar> createState() => Help_CalendarState();
}

class Help_CalendarState extends State<Help_Calendar> {
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
        CalendarGuide1(),
        CalendarGuide2(),
        CalendarGuide3(),
      ],
    );
  }
}

class CalendarGuide1 extends StatefulWidget {
  const CalendarGuide1({Key? key}) : super(key: key);

  @override
  State<CalendarGuide1> createState() => CalendarGuide1State();
}

class CalendarGuide1State extends State<CalendarGuide1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "캘린더 가이드",
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
          "images/calendar1.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class CalendarGuide2 extends StatefulWidget {
  const CalendarGuide2({Key? key}) : super(key: key);

  @override
  State<CalendarGuide2> createState() => CalendarGuide2State();
}

class CalendarGuide2State extends State<CalendarGuide2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "캘린더 가이드",
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
          "images/calendar2.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class CalendarGuide3 extends StatefulWidget {
  const CalendarGuide3({Key? key}) : super(key: key);

  @override
  State<CalendarGuide3> createState() => CalendarGuide3State();
}

class CalendarGuide3State extends State<CalendarGuide3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "캘린더 가이드",
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
          "images/calendar3.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}