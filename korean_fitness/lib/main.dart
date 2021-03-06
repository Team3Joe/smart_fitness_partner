import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:korean_fitness/Admin/customer_list.dart';
import 'package:korean_fitness/Analysis/analysis.dart';
import 'package:korean_fitness/Analysis/analysis_input.dart';
import 'package:korean_fitness/Analysis/analysis_result.dart';
import 'package:korean_fitness/Analysis/center_list.dart';
import 'package:korean_fitness/Analysis/center_map.dart';
import 'package:korean_fitness/Analysis/select_gender.dart';
import 'package:korean_fitness/Calendar/calender.dart';
import 'package:korean_fitness/Calendar/calender_analysis.dart';
import 'package:korean_fitness/Login/findMain.dart';
import 'package:korean_fitness/Login/findMain2.dart';
import 'package:korean_fitness/Login/log_in.dart';
import 'package:korean_fitness/Login/sign_up.dart';
import 'package:korean_fitness/Main/mainpage.dart';
import 'package:korean_fitness/Main/splashscreen.dart';
import 'package:korean_fitness/Program/cardiovascular_endurance.dart';
import 'package:korean_fitness/Program/flexibility.dart';
import 'package:korean_fitness/Program/speed_strength.dart';
import 'package:korean_fitness/Setting/customer_service.dart';
import 'package:korean_fitness/Setting/help.dart';
import 'package:korean_fitness/Setting/mypage.dart';
import 'package:korean_fitness/Setting/privacy_policy.dart';
import 'package:korean_fitness/Setting/setting.dart';

void main() {
  runApp(const MyApp());
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, __) {
        return GetMaterialApp(
          // debug banner
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: currentMode,
          routes: {
            // Analysis
            '/Analysis': (context) => const Analysis(),
            '/SelectGender': (context) => const SelectGender(),
            '/Analysis_data': (context) => const AnalysisData(),
            '/Analysis_result': (context) => PageViewDemo(),
            '/Center_list': (context) => CenterList(
                  list: const [],
                ),
            '/Center_map': (context) => CenterMap(),

            // Calendar
            '/Calender': (context) => const Calender(),
            '/Calender_alnalysis': (context) => PageViewDemo1(),

            // Login
            '/Sign_up': (context) => const SignUp(),
            '/Log_in': (context) => const LogIn(),
            '/Find_id': (context) => const FindMain(),
            '/Find_pw': (context) => const FindMain2(),

            // Admin
            '/Customer_list': (context) => const CustomerList(),

            // Main
            '/Mainpage': (context) => const MainPage(),
            '/loading': (context) => const SplashPage(),

            // My page
            '/Mypage': (context) => const MyPage(),

            // Program
            //'/Muscular_strength': (context) => const MuscularStrength(),
            '/Cardiovascular_endurance': (context) =>
                const CardiovascularEndurance(),
            '/Flexibility': (context) => const Flexibility(),
            '/Speed_strength': (context) => const SpeedStrength(),

            // Setting
            '/Setting': (context) => const Setting(),
            '/Help': (context) => const Help(),
            '/Customer_service': (context) => const CustomerService(),
            '/Privacy_policy': (context) => const PrivacyPolicy(),
          },
          initialRoute: '/loading',
        );
      },
    );
  }
}
