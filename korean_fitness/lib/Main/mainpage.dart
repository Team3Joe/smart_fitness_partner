import 'package:flutter/material.dart';
import 'package:korean_fitness/Analysis/analysis.dart';
import 'package:korean_fitness/Calendar/calender.dart';
import 'package:korean_fitness/Program/muscular_strength.dart';
import 'package:korean_fitness/Setting/mypage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // Property
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  // dispose는 정리해주는 역할
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
          TabBarView(
            controller : controller,
            // ignore: prefer_const_literals_to_create_immutables
            children: const[Analysis(),MuscularStrength(),Calender()],
          ),
        ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: TabBar(
          controller: controller,
          labelColor: Colors.blueAccent,
          indicatorColor: Colors.purpleAccent,
          tabs: const [
            Tab(
              icon: Icon(
                Icons.analytics,
                color: Colors.black,
              ),
              text: "분석",
            ),
            Tab(
              icon: Icon(
                Icons.fitness_center,
                color: Colors.black,
              ),
              text: '체력향상',
            ),
            Tab(
              icon: Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
              ),
              text: '캘린더',
            ),
          ],
        ),
      ),
    );
  }
}
