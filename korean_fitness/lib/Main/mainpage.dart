import 'package:flutter/material.dart';
import 'package:korean_fitness/Analysis/analysis.dart';
import 'package:korean_fitness/Calendar/calender.dart';
import 'package:korean_fitness/Program/muscular_strength.dart';
import 'package:korean_fitness/Setting/mypage.dart';
import 'package:korean_fitness/message5.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // Property
  late TabController controller;
  List <exercise> exerciseListm = [];
  List <exercise> exerciseListc = [];
  List <exercise> exerciseListf = [];
  List <exercise> exerciseLists = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    exerciseListm.add(exercise(
    exName:'숄더 프레스',
    imagePath:'images/mus1.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'덤벨 프레스',
    imagePath:'images/mus2.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'데드 리프트',
    imagePath:'images/mus3.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'와이드 스쿼트',
    imagePath:'images/mus4.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'밴트오버 래터럴레이즈',
    imagePath:'images/mus5.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'덤벨 업라이트 로우',
    imagePath:'images/mus6.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'숄더 프레스',
    imagePath:'images/mus1.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'덤벨 프레스',
    imagePath:'images/mus2.gif',
    exCount: '16회'
    ));
    exerciseListm.add(exercise(
    exName:'데드 리프트',
    imagePath:'images/mus3.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'와이드 스쿼트',
    imagePath:'images/mus4.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'밴트오버 래터럴레이즈',
    imagePath:'images/mus5.gif',
    exCount: '16 회'
    ));
    exerciseListm.add(exercise(
    exName:'덤벨 업라이트 로우',
    imagePath:'images/mus6.gif',
    exCount: '16 회'
    ));
    exerciseListc.add(exercise(
    exName:'점핑 잭',
    imagePath:'images/car1.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'제자리 뛰기',
    imagePath:'images/car2.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'발 바꾸어 뛰기',
    imagePath:'images/car3.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'허들리스 니레이즈',
    imagePath:'images/car4.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'푸쉬업 버피 테스트',
    imagePath:'images/car5.gif',
    exCount: '16 회'
    ));
    exerciseListc.add(exercise(
    exName:'스텝 박스',
    imagePath:'images/car6.gif',
    exCount: '30 초'
    ));exerciseListc.add(exercise(
    exName:'점핑 잭',
    imagePath:'images/car1.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'제자리 뛰기',
    imagePath:'images/car2.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'발 바꾸어 뛰기',
    imagePath:'images/car3.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'허들리스 니레이즈',
    imagePath:'images/car4.gif',
    exCount: '30 초'
    ));
    exerciseListc.add(exercise(
    exName:'푸쉬업 버피 테스트',
    imagePath:'images/car5.gif',
    exCount: '16 회'
    ));
    exerciseListc.add(exercise(
    exName:'스텝 박스',
    imagePath:'images/car6.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'푸쉬업 버피 테스트',
    imagePath:'images/spe1.gif',
    exCount: '16 회'
    ));
    exerciseLists.add(exercise(
    exName:'버피 테스트 변형',
    imagePath:'images/spe2.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'쪼그려 높이 뛰기',
    imagePath:'images/spe3.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'스텝 박스',
    imagePath:'images/spe4.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'사이드 스텝',
    imagePath:'images/spe5.gif',
    exCount: '16 회'
    ));
    exerciseLists.add(exercise(
    exName:'발 바꾸어 뛰기',
    imagePath:'images/spe6.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'푸쉬업 버피 테스트',
    imagePath:'images/spe1.gif',
    exCount: '16 회'
    ));
    exerciseLists.add(exercise(
    exName:'버피 테스트 변형',
    imagePath:'images/spe2.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'쪼그려 높이 뛰기',
    imagePath:'images/spe3.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'스텝 박스',
    imagePath:'images/spe4.gif',
    exCount: '30 초'
    ));
    exerciseLists.add(exercise(
    exName:'사이드 스텝',
    imagePath:'images/spe5.gif',
    exCount: '16 회'
    ));
    exerciseLists.add(exercise(
    exName:'발 바꾸어 뛰기',
    imagePath:'images/spe6.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'허리 비틀기',
    imagePath:'images/fle1.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'스탠딩 사이드 크런치',
    imagePath:'images/fle2.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'스쿼트',
    imagePath:'images/fle3.gif',
    exCount: '16회'
    ));
    exerciseListf.add(exercise(
    exName:'슈퍼맨',
    imagePath:'images/fle4.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'한발서서 균형잡기',
    imagePath:'images/fle5.gif',
    exCount: '16 회'
    ));
    exerciseListf.add(exercise(
    exName:'사이드 스텝',
    imagePath:'images/fle6.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'허리 비틀기',
    imagePath:'images/fle1.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'스탠딩 사이드 크런치',
    imagePath:'images/fle2.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'스쿼트',
    imagePath:'images/fle3.gif',
    exCount: '16 회'
    ));
    exerciseListf.add(exercise(
    exName:'슈퍼맨',
    imagePath:'images/fle4.gif',
    exCount: '30 초'
    ));
    exerciseListf.add(exercise(
    exName:'한발서서 균형잡기',
    imagePath:'images/fle5.gif',
    exCount: '16 회'
    ));
    exerciseListf.add(exercise(
    exName:'사이드 스텝',
    imagePath:'images/fle6.gif',
    exCount: '30 초'
    ));
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
            children: [const Analysis(),MuscularStrength(listM: exerciseListm, listC: exerciseListc, listF:exerciseListf, listS:exerciseLists),const Calender()],
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
