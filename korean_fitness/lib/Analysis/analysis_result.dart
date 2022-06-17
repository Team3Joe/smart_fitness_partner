import 'package:flutter/material.dart';
import 'package:korean_fitness/message.dart';
import 'package:korean_fitness/message2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;

const gridColor = Color.fromARGB(255, 129, 66, 219);
const titleColor = Color.fromARGB(255, 129, 66, 219);
const myColor = Color.fromARGB(255, 255, 133, 202);
const meanColor = Color.fromARGB(255, 183, 120, 255);
const tier1Color = Color.fromARGB(255, 92, 209, 229);

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
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
      scrollDirection: Axis.vertical,
      children: const [
        AnalysisResult(),
        BarChartSample1(),
        BarChartSample2(),
        BarChartSample3(),
        BarChartSample4(),
        BarChartSample5(),
        result()
      ],
    );
  }
}

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor1 = const Color.fromARGB(255, 211, 216, 114);
  final Duration animDuration1 = const Duration(milliseconds: 250);

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String bmi2;
  late double bmi3;
  late String rating;
  int touchedIndex1 = -1;

  bool isPlaying1 = true;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);
    bmi2 = bmi.toStringAsFixed(1);
    bmi3 = double.parse(bmi2);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "신체조성 분석 결과",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 43, 20),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color.fromARGB(255, 223, 227, 97),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          '신체조성',
                          style: TextStyle(
                              color: Color.fromARGB(255, 15, 66, 74),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          'BMI, 체지방률 분석 그래프',
                          style: TextStyle(
                              color: Color.fromARGB(255, 111, 153, 55),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying1 ? randomData1() : mainBarData1(),
                              swapAnimationDuration: animDuration1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: isPlaying1 ? Text("결과확인하기") : Text("결과확인완료"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(156, 7, 86, 39),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying1 = !isPlaying1;
                            if (isPlaying1) {
                              // refreshState1();
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "images/arrow.gif",
            width: 70,
            height: 70,
          )
        ]),
      ),
    );
  }

  BarChartGroupData makeGroupData1(
    int x,
    double y, {
    bool isTouched1 = false,
    Color barColor1 = Colors.white,
    double width1 = 22,
    List<int> showTooltips1 = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched1 ? y + 1 : y,
          color: isTouched1 ? Color.fromARGB(255, 17, 83, 61) : barColor1,
          width: width1,
          borderSide: isTouched1
              ? BorderSide(color: Color.fromARGB(255, 17, 83, 61), width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 35,
            color: barBackgroundColor1,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips1,
    );
  }

  List<BarChartGroupData> showingGroups1() => List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData1(0, bmi3, isTouched1: i == touchedIndex1);
          case 1:
            return makeGroupData1(1, 22, isTouched1: i == touchedIndex1);
          case 2:
            return makeGroupData1(2, fatMass, isTouched1: i == touchedIndex1);
          case 3:
            return makeGroupData1(3, 27, isTouched1: i == touchedIndex1);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData1() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Color.fromARGB(223, 118, 175, 141),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '본인 BMI';
                  break;
                case 1:
                  weekDay = '적정(표준) BMI';
                  break;
                case 2:
                  weekDay = '본인 체지방률';
                  break;
                case 3:
                  weekDay = '적정(표준)\n체지방률';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 17, 83, 61),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex1 = -1;
              return;
            }
            touchedIndex1 = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles1,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups1(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles1(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 8, 54, 39),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('본인 BMI', style: style);
        break;
      case 1:
        text = const Text('표준(적정) BMI', style: style);
        break;
      case 2:
        text = const Text('본인 체지방률', style: style);
        break;
      case 3:
        text = const Text('표준(적정) 체지방률', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData1() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles1,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(4, (i) {
        switch (i) {
          case 0:
            return makeGroupData1(0, Random().nextInt(25).toDouble() + 6,
                barColor1: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData1(1, Random().nextInt(25).toDouble() + 6,
                barColor1: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData1(2, Random().nextInt(25).toDouble() + 6,
                barColor1: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData1(3, Random().nextInt(25).toDouble() + 6,
                barColor1: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  // Future<dynamic> refreshState1() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //       animDuration1 + const Duration(milliseconds: 50));
  //   if (isPlaying1) {
  //     await refreshState1();
  //   }
  // }
}

//------------------------------------------------------------------------------------------

class BarChartSample2 extends StatefulWidget {
  final List<Color> availableColors2 = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final Color barBackgroundColor2 = Color.fromARGB(255, 184, 114, 216);
  final Duration animDuration2 = const Duration(milliseconds: 250);

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String rating;
  int touchedIndex2 = -1;

  bool isPlaying2 = true;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "유연성 분석 결과",
          style: TextStyle(
              color: Color.fromARGB(255, 43, 35, 70),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color.fromARGB(255, 184, 114, 216),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          '유연성',
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 15, 74),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          '앞으로 구부리기 비교 분석 그래프',
                          style: TextStyle(
                              color: Color.fromARGB(255, 83, 55, 153),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying2 ? randomData2() : mainBarData2(),
                              swapAnimationDuration: animDuration2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: isPlaying2 ? Text("결과확인하기") : Text("결과확인완료"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(156, 111, 0, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying2 = !isPlaying2;
                            if (isPlaying2) {
                              // refreshState2();
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "images/arrow.gif",
            width: 70,
            height: 70,
          )
        ]),
      ),
    );
  }

  BarChartGroupData makeGroupData2(
    int x,
    double y, {
    bool isTouched2 = false,
    Color barColor2 = Colors.white,
    double width2 = 22,
    List<int> showTooltips2 = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched2 ? y + 1 : y,
          color: isTouched2 ? Colors.deepPurple : barColor2,
          width: width2,
          borderSide: isTouched2
              ? BorderSide(color: Colors.deepPurple, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 35,
            color: barBackgroundColor2,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips2,
    );
  }

  List<BarChartGroupData> showingGroups2() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData2(0, forwardBending,
                isTouched2: i == touchedIndex2);
          case 1:
            return makeGroupData2(1, 20, isTouched2: i == touchedIndex2);
          case 2:
            return makeGroupData2(2, 24, isTouched2: i == touchedIndex2);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData2() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Color.fromARGB(223, 132, 118, 175),
            getTooltipItem: (group2, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group2.x.toInt()) {
                case 0:
                  weekDay = '본인\n 앞으로구부르기';
                  break;
                case 1:
                  weekDay = '동나이대\n 평균\n 앞으로구부르기';
                  break;
                case 2:
                  weekDay = '다이아티어\n 평균\n앞으로구부르기';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event2, barTouchResponse2) {
          setState(() {
            if (!event2.isInterestedForInteractions ||
                barTouchResponse2 == null ||
                barTouchResponse2.spot == null) {
              touchedIndex2 = -1;
              return;
            }
            touchedIndex2 = barTouchResponse2.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles2,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups2(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles2(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 52, 15, 74),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('본인', style: style);
        break;
      case 1:
        text = const Text('동나이대 평균', style: style);
        break;
      case 2:
        text = const Text('다이아티어 평균', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData2() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles2,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData2(0, Random().nextInt(24).toDouble() + 6,
                barColor2: widget.availableColors2[
                    Random().nextInt(widget.availableColors2.length)]);
          case 1:
            return makeGroupData2(1, Random().nextInt(24).toDouble() + 6,
                barColor2: widget.availableColors2[
                    Random().nextInt(widget.availableColors2.length)]);
          case 2:
            return makeGroupData2(2, Random().nextInt(24).toDouble() + 6,
                barColor2: widget.availableColors2[
                    Random().nextInt(widget.availableColors2.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  // Future<dynamic> refreshState2() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //       animDuration2 + const Duration(milliseconds: 50));
  //   if (isPlaying2) {
  //     await refreshState2();
  //   }
  // }
}

//------------------------------------------------------------------------------------------

class BarChartSample3 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  final Color barBackgroundColor3 = Color.fromARGB(255, 216, 114, 165);
  final Duration animDuration3 = const Duration(milliseconds: 250);

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String rating;
  int touchedIndex3 = -1;

  bool isPlaying3 = true;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "순발력 분석 결과",
          style: TextStyle(
              color: Color.fromARGB(255, 85, 33, 80),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color.fromARGB(255, 216, 114, 151),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          '순발력',
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 15, 74),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          '멀리뛰기 비교 분석 그래프',
                          style: TextStyle(
                              color: Color.fromARGB(255, 130, 55, 153),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying3 ? randomData3() : mainBarData3(),
                              swapAnimationDuration: animDuration3,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: isPlaying3 ? Text("결과확인하기") : Text("결과확인완료"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(146, 187, 0, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying3 = !isPlaying3;
                            // if (isPlaying3) {
                            //   refreshState();
                            // }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "images/arrow.gif",
            width: 70,
            height: 70,
          )
        ]),
      ),
    );
  }

  BarChartGroupData makeGroupData3(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.purple : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.purple, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 230,
            color: barBackgroundColor3,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups3() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData3(0, longJump, isTouched: i == touchedIndex3);
          case 1:
            return makeGroupData3(1, 170, isTouched: i == touchedIndex3);
          case 2:
            return makeGroupData3(2, 180, isTouched: i == touchedIndex3);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData3() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Color.fromARGB(223, 132, 118, 175),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '본인 멀리뛰기(cm)';
                  break;
                case 1:
                  weekDay = '동나이대\n 평균 멀리뛰기(cm)';
                  break;
                case 2:
                  weekDay = '다이아티어\n 평균 멀리뛰기(cm)';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex3 = -1;
              return;
            }
            touchedIndex3 = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles3,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups3(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles3(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 52, 15, 74),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('본인', style: style);
        break;
      case 1:
        text = const Text('동나이대 평균', style: style);
        break;
      case 2:
        text = const Text('다이아티어 평균', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData3() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles3,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData3(0, Random().nextInt(170).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData3(1, Random().nextInt(170).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData3(2, Random().nextInt(170).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  // Future<dynamic> refreshState() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //       animDuration3 + const Duration(milliseconds: 50));
  //   if (isPlaying3) {
  //     await refreshState();
  //   }
  // }
}

// ---------------------------------------------------------------------------------------------------

class BarChartSample4 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample4State();
}

class BarChartSample4State extends State<BarChartSample4> {
  final Color barBackgroundColor4 = const Color(0xff72d8bf);
  final Duration animDuration4 = const Duration(milliseconds: 250);

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String rating;
  int touchedIndex4 = -1;

  bool isPlaying4 = true;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "근력 분석 결과",
          style: TextStyle(
              color: Color.fromARGB(255, 32, 69, 71),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: const Color(0xff81e5cd),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          '근력',
                          style: TextStyle(
                              color: Color(0xff0f4a3c),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          '악력 비교 분석 그래프',
                          style: TextStyle(
                              color: Color(0xff379982),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying4 ? randomData4() : mainBarData4(),
                              swapAnimationDuration: animDuration4,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: isPlaying4 ? Text("결과확인하기") : Text("결과확인완료"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(183, 7, 86, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying4 = !isPlaying4;
                            // if (isPlaying) {
                            //   refreshState();
                            // }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "images/arrow.gif",
            width: 70,
            height: 70,
          )
        ]),
      ),
    );
  }

  BarChartGroupData makeGroupData4(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.lightGreenAccent : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.lightGreenAccent, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 40,
            color: barBackgroundColor4,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups4() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData4(0, grip, isTouched: i == touchedIndex4);
          case 1:
            return makeGroupData4(1, 27, isTouched: i == touchedIndex4);
          case 2:
            return makeGroupData4(2, 29, isTouched: i == touchedIndex4);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData4() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '본인 악력';
                  break;
                case 1:
                  weekDay = '동나이대\n 평균 악력';
                  break;
                case 2:
                  weekDay = '다이아티어\n 평균 악력';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.lightGreenAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex4 = -1;
              return;
            }
            touchedIndex4 = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles4,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups4(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles4(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 5, 43, 5),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('본인', style: style);
        break;
      case 1:
        text = const Text('동나이대 평균', style: style);
        break;
      case 2:
        text = const Text('다이아티어 평균', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData4() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles4,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData4(0, Random().nextInt(33).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData4(1, Random().nextInt(33).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData4(2, Random().nextInt(33).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  // Future<dynamic> refreshState() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //       animDuration + const Duration(milliseconds: 50));
  //   if (isPlaying4) {
  //     await refreshState();
  //   }
  // }
}

// ---------------------------------------------------------------------------------------------------

class BarChartSample5 extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  const BarChartSample5({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample5State();
}

class BarChartSample5State extends State<BarChartSample5> {
  final Color barBackgroundColor5 = Color.fromARGB(255, 114, 209, 216);
  final Duration animDuration5 = const Duration(milliseconds: 250);

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String rating;
  int touchedIndex5 = -1;

  bool isPlaying5 = true;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "근지구력 분석 결과",
          style: TextStyle(
              color: Color.fromARGB(255, 13, 42, 89),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          AspectRatio(
            aspectRatio: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              color: Color.fromARGB(255, 129, 222, 229),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Text(
                          '근지구력',
                          style: TextStyle(
                              color: Color.fromARGB(255, 15, 42, 74),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          '윗몸일으키기 비교 분석 그래프',
                          style: TextStyle(
                              color: Color.fromARGB(255, 55, 132, 153),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: BarChart(
                              isPlaying5 ? randomData5() : mainBarData5(),
                              swapAnimationDuration: animDuration5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(
                        child: isPlaying5 ? Text("결과확인하기") : Text("결과확인완료"),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(196, 7, 33, 86),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isPlaying5 = !isPlaying5;
                            // if (isPlaying) {
                            //   refreshState();
                            // }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "images/arrow.gif",
            width: 70,
            height: 70,
          )
        ]),
      ),
    );
  }

  BarChartGroupData makeGroupData5(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.lightBlueAccent : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.lightBlueAccent, width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 60,
            color: barBackgroundColor5,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups5() => List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData5(0, situp, isTouched: i == touchedIndex5);
          case 1:
            return makeGroupData5(1, 39, isTouched: i == touchedIndex5);
          case 2:
            return makeGroupData5(2, 45, isTouched: i == touchedIndex5);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData5() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = '본인\n 윗몸일으키기';
                  break;
                case 1:
                  weekDay = '동나이대\n 평균\n 윗몸일으키기';
                  break;
                case 2:
                  weekDay = '다이아티어\n 평균\n 윗몸일으키기';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex5 = -1;
              return;
            }
            touchedIndex5 = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles5,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups5(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles5(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 5, 30, 43),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('본인', style: style);
        break;
      case 1:
        text = const Text('동나이대 평균', style: style);
        break;
      case 2:
        text = const Text('다이아티어 평균', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData5() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles5,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(3, (i) {
        switch (i) {
          case 0:
            return makeGroupData5(0, Random().nextInt(50).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData5(1, Random().nextInt(50).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData5(2, Random().nextInt(50).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  // Future<dynamic> refreshState() async {
  //   setState(() {});
  //   await Future<dynamic>.delayed(
  //       animDuration + const Duration(milliseconds: 50));
  //   if (isPlaying) {
  //     await refreshState();
  //   }
  // }
}

// ----------------------------------------------------------------------------------------------------

class AnalysisResult extends StatefulWidget {
  const AnalysisResult({Key? key}) : super(key: key);

  @override
  State<AnalysisResult> createState() => _AnalysisResultState();
}

class _AnalysisResultState extends State<AnalysisResult> {
  int selectedDataSetIndex = -1;

  late double height;
  late double weight;
  late double age;
  late double grip;
  late double forwardBending;
  late double longJump;
  late double fatMass;
  late double situp;
  late double bmi;
  late String rating;

  @override
  void initState() {
    super.initState();

    height = double.parse(Message2.height);
    weight = double.parse(Message2.weight);
    age = double.parse(Message2.age);
    grip = double.parse(Message2.grip);
    forwardBending = double.parse(Message2.forwardBending);
    longJump = double.parse(Message2.longJump);
    fatMass = double.parse(Message2.fatMass);
    situp = double.parse(Message2.situp);
    rating = Message2.ratingResult;
    bmi = double.parse(Message2.bmi);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
      } else if (rating == "B") {
        rating = "골드";
      } else if (rating == "C") {
        rating == "실버";
      } else {
        rating = "브론즈";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("스마트 체력 테스트 분석 결과"),
        backgroundColor: Color.fromARGB(255, 92, 209, 229),
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "다이아 / 골드 / 실버 / 브론즈\n\n 총 4개의 티어가 존재합니다.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "당신의 티어는 '${rating}' 티어입니다.",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDataSetIndex = -1;
                    });
                  },
                  child: Text(
                    'Pentagon status'.toUpperCase(),
                    style: const TextStyle(
                      color: titleColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rawDataSets()
                      .asMap()
                      .map((index, value) {
                        final isSelected = index == selectedDataSetIndex;
                        return MapEntry(
                          index,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDataSetIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              height: 30,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? gridColor.withOpacity(0.5)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(46),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInToLinear,
                                    padding: EdgeInsets.all(isSelected ? 8 : 6),
                                    decoration: BoxDecoration(
                                      color: value.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInToLinear,
                                    style: TextStyle(
                                      color:
                                          isSelected ? value.color : gridColor,
                                    ),
                                    child: Text(value.title),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
                ),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: RadarChart(
                    RadarChartData(
                      radarTouchData: RadarTouchData(
                          touchCallback: (FlTouchEvent event, response) {
                        if (!event.isInterestedForInteractions) {
                          setState(() {
                            selectedDataSetIndex = -1;
                          });
                          return;
                        }
                        setState(() {
                          selectedDataSetIndex =
                              response?.touchedSpot?.touchedDataSetIndex ?? -1;
                        });
                      }),
                      dataSets: showingDataSets(),
                      radarBackgroundColor: Colors.white,
                      borderData: FlBorderData(show: false),
                      radarBorderData: const BorderSide(color: Colors.white24),
                      titlePositionPercentageOffset: 0.18,
                      titleTextStyle:
                          const TextStyle(color: titleColor, fontSize: 17),
                      getTitle: (index) {
                        switch (index) {
                          case 0:
                            return '신체조성';
                          case 4:
                            return '근지구력';
                          case 3:
                            return '근력';
                          case 2:
                            return '유연성';
                          case 1:
                            return '순발력';
                          default:
                            return '';
                        }
                      },
                      tickCount: 1,
                      ticksTextStyle: const TextStyle(
                          color: Colors.transparent, fontSize: 15),
                      tickBorderData: const BorderSide(color: Colors.white),
                      gridBorderData:
                          const BorderSide(color: gridColor, width: 2),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 400),
                  ),
                ),
                //---------------------------------------------------------------------------
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                        quarterTurns: 1,
                        child: Image.asset(
                          "images/slide.gif",
                          width: 70,
                          height: 70,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "밑으로 넘기면서 결과를 확인해보세요!",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      var index = entry.key;
      var rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.6)
            : rawDataSet.color.withOpacity(0.02),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 5 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 5 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(
        title: '다이아티어 평균 능력치',
        color: tier1Color,
        values: [
          21, //bmi
          18, //멀리뛰기
          24, //앞으로 구부리기
          29, //악력
          45, //윗몸 일으키기
        ],
      ),
      RawDataSet(
        title: '나이대 평균 능력치',
        color: meanColor,
        values: [
          22, //bmi
          17, //멀리뛰기
          20, //앞으로 구부리기
          27, //악력
          39, //윗몸 일으키기
        ],
      ),
      RawDataSet(
        title: '나의 능력치',
        color: myColor,
        values: [
          bmi, //bmi
          longJump / 10, //멀리뛰기 155
          forwardBending, //앞으로 구부리기 25
          grip, //악력 28
          situp, //윗몸 일으키기 39
        ],
      ),
    ];
  }
}

class RawDataSet {
  final String title;
  final Color color;
  final List<double> values;

  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });
}

// -------------------------------------------------------------------------------------------

class result extends StatefulWidget {
  const result({Key? key}) : super(key: key);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  late String height;
  late String weight;
  late String age;
  late String grip;
  late String forwardBending;
  late String longJump;
  late String fatMass;
  late String situp;
  late double bmi;
  late String bmi2;
  late double bmi3;
  late String rating;
  late String gender;
  late String tier;
  late String uId;

  late String result;

  @override
  void initState() {
    super.initState();

    height = Message2.height;
    weight = Message2.weight;
    age = Message2.age;
    grip = Message2.grip;
    forwardBending = Message2.forwardBending;
    longJump = Message2.longJump;
    fatMass = Message2.fatMass;
    situp = Message2.situp;
    rating = Message2.ratingResult;
    gender = Message2.gender;
    bmi = double.parse(Message2.bmi);
    bmi2 = bmi.toStringAsFixed(1);
    bmi3 = double.parse(bmi2);

    setState(() {
      if (rating == "A") {
        rating = "다이아";
        Message2.tier = rating;
      } else if (rating == "B") {
        rating = "골드";
        Message2.tier = rating;
      } else if (rating == "C") {
        rating == "실버";
        Message2.tier = rating;
      } else {
        rating = "브론즈";
        Message2.tier = rating;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "스마트 체력 테스트",
          style: TextStyle(
              color: Color.fromARGB(255, 13, 42, 89),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/letter_save.png"),
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 3, 137, 250),
                    Color.fromARGB(255, 10, 36, 170),
                    //add more colors
                  ]),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color:
                            Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
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
                  gender = Message2.gender;
                  height = Message2.height;
                  weight = Message2.weight;
                  age = Message2.age;
                  grip = Message2.grip;
                  forwardBending = Message2.forwardBending;
                  longJump = Message2.longJump;
                  fatMass = Message2.fatMass;
                  situp = Message2.situp;
                  bmi = bmi3;
                  rating = Message2.tier;
                  uId = Message.uId;
                  insert_result();
                },
                label: const Text(
                  "분석결과 저장하기",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                icon: const Icon(
                  Icons.save_alt,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset("images/letter_program.png"),
            const SizedBox(
              height: 10,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 60, 197, 113),
                    Color.fromARGB(255, 11, 135, 79),
                    //add more colors
                  ]),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color:
                            Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                        blurRadius: 10) //blur radius of shadow
                  ]),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  onSurface: Colors.transparent,
                  shadowColor: Colors.transparent,
                  //make color or elevated button transparent
                ),
                onPressed: () {},
                label: const Text(
                  "체력향상 프로그램 보러가기",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// function
  insert_result() async {
    var url = Uri.parse(
        'http://localhost:8080/Flutter/fitness/analysis_result_insert.jsp?gender=$gender&height=$height&weight=$weight&age=$age&grip=$grip&forwardBending=$forwardBending&longJump=$longJump&fatMass=$fatMass&situp=$situp&bmi=$bmi&rating=$rating&uId=$uId');
    var response = await http.get(url);
    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];

      if (result == 'OK') {
        _showDialog(context);
      } else {
        errorSnackBar(context);
      }
    });
  }

  _showDialog(BuildContext ctx) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('분석결과 입력'),
            content: const Text('입력이 완료되었습니다'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/Mainpage');
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('사용자 정보 입력에 문제가 발생하였습니다.'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
