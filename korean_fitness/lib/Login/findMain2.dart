import 'package:flutter/material.dart';
import 'package:korean_fitness/Login/find_id.dart';
import 'package:korean_fitness/Login/find_pw.dart';

class FindMain2 extends StatefulWidget {
  const FindMain2({Key? key}) : super(key: key);

  @override
  State<FindMain2> createState() => _FindMain2State();
}

class _FindMain2State extends State<FindMain2>
    with SingleTickerProviderStateMixin {
  // Property
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TabBarView(
          controller: controller,
          children: const [
            FindPw(),
            FindId(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 164, 154, 239),
        height: 60,
        child: TabBar(
          controller: controller,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              text: 'PW 재설정',
            ),
            Tab(
              text: 'ID 찾기',
              
            ),
          ],
        ),
      ),
    );
  }
}
